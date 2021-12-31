import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';

import '../models/post.dart';

class EditForm extends StatefulWidget {
  const EditForm({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _key = GlobalKey<FormState>();
  String _title = '';
  String _subtitle = '';
  String _body = '';

  final ImagePicker _picker = ImagePicker();
  XFile? _thumbnail;
  bool _showProgress = false;

  _getImageFromCamera(ImageSource src) async {
    final pickedImage = await _picker.pickImage(
      source: src,
      imageQuality: 100,
    );
    setState(() {
      _thumbnail = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _request = context.watch<ConnectNetworkService>();
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          color: Color(0xFFE6F8F2),
          fontSize: 18,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
        ),
        title: const Text('Edit your blog post'),
        bottom: _showProgress
            ? const PreferredSize(
                preferredSize: Size(4, 4),
                child: LinearProgressIndicator(),
              )
            : null,
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    initialValue: widget.post.title,
                    enabled: !_showProgress,
                    style: Theme.of(context).textTheme.subtitle1,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Write the title for your blog post here.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid title.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _title = newValue!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    initialValue: widget.post.subtitle,
                    enabled: !_showProgress,
                    style: const TextStyle(
                      color: Color(0xFFF2F8F2),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Subtitle',
                      hintText:
                          'Write an appealing subtitle for your blog post here.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid subtitle.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _subtitle = newValue!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: const Icon(
                                        Icons.photo_library,
                                        color: Color(0xFFE6F8F2),
                                      ),
                                      title: const Text('Photo Library'),
                                      onTap: () {
                                        _getImageFromCamera(
                                            ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.photo_camera,
                                        color: Color(0xFFE6F8F2),
                                      ),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        _getImageFromCamera(ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    const ListTile(),
                                  ],
                                );
                              },
                            );
                          },
                          child: _thumbnail != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(_thumbnail!.path),
                                    fit: BoxFit.scaleDown,
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    widget.post.thumbnailUrl,
                                    fit: BoxFit.scaleDown,
                                  )),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-0.95, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F0F17),
                            borderRadius: BorderRadius.circular(8), //
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(6, 0, 6, 4),
                            child: Text(
                              'Thumbnail',
                              style: TextStyle(
                                color: Color(0xFFE6F8F2),
                                fontSize: 10.5,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    initialValue: widget.post.bodyText,
                    enabled: !_showProgress,
                    maxLines: 12,
                    style: const TextStyle(
                      color: Color(0xFFF2F8F2),
                    ),
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Body',
                      hintText: 'Write your post here.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid title.";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _body = newValue!;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      setState(() {
                        _showProgress = true;
                      });
                      _key.currentState!.save();
                      Map<String, String> _data = {
                        'title': _title,
                        'subtitle': _subtitle,
                        'body': _body,
                      };
                      if (_thumbnail == null) {
                        await _request.post(
                          'https://corum.herokuapp.com/blog/${widget.post.slug}/edit-post/',
                          _data,
                        );
                      } else {
                        await _request.postMultipart(
                          'https://corum.herokuapp.com/blog/${widget.post.slug}/edit-post/',
                          _data,
                          _thumbnail!.path,
                        );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Your post was edited successfully!\n\n\n\n')),
                      );

                      setState(() {
                        _showProgress = false;
                      });

                      Navigator.pop(context, true);
                    }
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
