import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:corum/api/GetCookies.dart';
import 'package:provider/provider.dart';

class formstateful extends StatefulWidget {
  @override
  formstate createState() => formstate();
}

class formstate extends State<formstateful> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController intialdateval = TextEditingController();
  TextEditingController intialtimeval = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  Future _selectDate() async {
    final picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030)) as DateTime;
    if (picked != null)
      setState(() => {intialdateval.text = DateFormat.yMd().format(picked)});
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked_s = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        intialtimeval.text = picked_s.format(context);
        selectedTime = picked_s;
      });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final temp = File(image.path);
      setState(() => this.image1 = temp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImage2() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final temp = File(image.path);
      setState(() => this.image2 = temp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String title = '';
  String date = '';
  String time = '';
  String media = '';
  String url = '';
  String tipe = '';
  String description = '';
  File? image1;
  File? image2;
  @override
  Widget build(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();
    return Scaffold(
        appBar: AppBar(
          title: Text("Event Form Admin Only"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildTitle(),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: buildDate()),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: buildTime()),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: buildMedia()),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: buildTipe()),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: buildUrl()),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildDescription()),
                  Container(child: buildThumbnail()),
                  Container(child: buildPageImage()),
                  RaisedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        final isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          if (image1 != null && image2 != null) {
                            _formKey.currentState!.save();

                            final String base64file1 =
                                base64Encode(image1!.readAsBytesSync());
                            final String fileName1 =
                                image1!.path.split("/").last;
                            final String base64file2 =
                                base64Encode(image2!.readAsBytesSync());
                            final String fileName2 =
                                image2!.path.split("/").last;
                            final response = await request.post(
                                "https://corum.herokuapp.com/event/post/",
                                convert.jsonEncode(<String, String>{
                                  'title': title,
                                  'tanggal': date,
                                  'waktu': time,
                                  'media': media,
                                  'tipe': tipe,
                                  'url': url,
                                  'deskripsi': description,
                                  'file1': base64file1,
                                  'name1': fileName1,
                                  'file2': base64file2,
                                  'name2': fileName2,
                                }));
                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Event Succesfully Save!"),
                              ));
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("An error occured, please try again."),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Please Insert Image."),
                            ));
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildTitle() => TextFormField(
      decoration: new InputDecoration(
        labelText: "Title",
        icon: Icon(Icons.textsms_outlined),
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      validator: (value) {
        if (value != null) {
          if (value.isEmpty) {
            return 'Title tidak boleh kosong';
          }
          return null;
        }
      },
      onSaved: (value) => setState(() => title = value!));
  Widget buildDate() => TextFormField(
      controller: intialdateval,
      onTap: () {
        _selectDate();
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      maxLines: 1,
      validator: (value) {
        if (value!.isEmpty || value.length < 1) {
          return 'Date tidak boleh kosong';
        }
        return null;
      },
      decoration: new InputDecoration(
        labelText: "Date",
        icon: Icon(Icons.calendar_today_rounded),
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      onSaved: (value) => setState(() => date = value!));
  Widget buildTime() => TextFormField(
      controller: intialtimeval,
      onTap: () {
        _selectTime(context);
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      maxLines: 1,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Time tidak boleh kosong';
        }
        return null;
      },
      decoration: new InputDecoration(
        labelText: "Time",
        icon: Icon(Icons.access_time_sharp),
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      onSaved: (value) => setState(() => time = value!));
  Widget buildMedia() => TextFormField(
      decoration: new InputDecoration(
        labelText: "Media",
        icon: Icon(Icons.video_camera_front_outlined),
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Media tidak boleh kosong';
        }
        return null;
      },
      onSaved: (value) => setState(() => media = value!));
  Widget buildTipe() => TextFormField(
      decoration: new InputDecoration(
        labelText: "Tipe",
        icon: Icon(Icons.chat_bubble_outline),
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Tipe tidak boleh kosong';
        }
        return null;
      },
      onSaved: (value) => setState(() => tipe = value!));
  Widget buildUrl() => TextFormField(
      decoration: new InputDecoration(
        labelText: "URL",
        icon: Icon(Icons.link),
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'URL tidak boleh kosong';
        }
        bool _validURL = Uri.parse(value).isAbsolute;
        if (!_validURL) {
          return 'URL tidak valid';
        }
        return null;
      },
      onSaved: (value) => setState(() => url = value!));
  Widget buildDescription() => TextFormField(
      decoration: new InputDecoration(
        labelText: "Description",
        icon: Icon(Icons.text_snippet),
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      keyboardType: TextInputType.multiline,
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Description tidak boleh kosong';
        }
        return null;
      },
      onSaved: (value) => setState(() => description = value!));
  Widget buildThumbnail() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text("Thumbnail: ", style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  pickImage();
                },
                child: image1 != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(image1!.path),
                          fit: BoxFit.scaleDown,
                        ))
                    : Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
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
          ],
        ),
      );
  Widget buildPageImage() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text("Page Image:", style: TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  pickImage2();
                },
                child: image2 != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(image2!.path),
                          fit: BoxFit.scaleDown,
                        ))
                    : Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
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
          ],
        ),
      );
}
