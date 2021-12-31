import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';

class PostForm extends StatefulWidget {
  const PostForm({Key? key}) : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _key = GlobalKey<FormState>();
  String _title = '';
  String _subtitle = '';
  String _body = '';

  final ImagePicker _picker = ImagePicker();
  XFile? _thumbnail;
  bool _showThumbnailMessage = false;
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
        backgroundColor: Colors.greenAccent.shade200,
        titleTextStyle: const TextStyle(
          color: Color(0xFFE6F8F2),
          fontSize: 18,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
        ),
        title: const Text('Add a blog post'),
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
                    enabled: !_showProgress,
                    style: Theme.of(context).textTheme.subtitle1,
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
                              : Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: _showThumbnailMessage
                                            ? const Color(0xFFB00020)
                                            : const Color(0xFF2C2E3D),
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-0.95, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2EFE8),
                            borderRadius: BorderRadius.circular(8), //
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(6, 0, 6, 4),
                            child: Text(
                              'Thumbnail',
                              style: TextStyle(
                                color: Color(0xFF0F0802),
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
                    enabled: !_showProgress,
                    maxLines: 12,
                    style: Theme.of(context).textTheme.subtitle1,
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
                    if (_thumbnail == null) {
                      setState(() {
                        _showThumbnailMessage = true;
                      });
                    }
                    if (_key.currentState!.validate() && _thumbnail != null) {
                      setState(() {
                        _showProgress = true;
                      });
                      _key.currentState!.save();
                      Map<String, String> _data = {
                        'title': _title,
                        'subtitle': _subtitle,
                        'body': _body,
                      };
                      await _request.postMultipart(
                          'https://corum.herokuapp.com/blog/add-post/',
                          _data,
                          _thumbnail!.path);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Your post was created successfully!\n\n\n\n')),
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
