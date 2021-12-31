// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:corum/api/GetCookies.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'widgets/textfield_widget.dart';
import 'profile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final temp = File(image.path);
      setState(() => this.image = temp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String firstName = '';
  String lastName = '';
  String email = '';
  String bio = '';
  File? image;
  @override
  Widget build(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();
    String username = request.username;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profil"),
        backgroundColor: Colors.greenAccent.shade200,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: const Icon(Icons.add_sharp),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldWidget(
                  label: 'Nama Depan',
                  text: firstName,
                  onSaved: (String? value) {
                    setState(() {
                      firstName = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldWidget(
                  label: 'Nama Belakang',
                  text: lastName,
                  onSaved: (String? value) {
                    setState(() {
                      lastName = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldWidget(
                  label: 'Bio',
                  text: bio,
                  onSaved: (String? value) {
                    setState(() {
                      bio = value!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(59, 148, 94, 1.0),
                    shape: StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    "Pilih Foto Profil",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    pickImage();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(59, 148, 94, 1.0),
                    shape: StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    //post
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      _formKey.currentState!.save();
                    }
                    final String base64file =
                        base64Encode(image!.readAsBytesSync());
                    final String fileName = image!.path.split("/").last;
                    final response = await request.post(
                        "https://corum.herokuapp.com/profile/edit/flutter",
                        convert.jsonEncode(<String, String>{
                          'firstName': firstName,
                          'lastName': lastName,
                          'username': username,
                          'bio': bio,
                          'file': base64file,
                          'nama': fileName
                        }));
                    //munculin popup
                    if (response['status'] == 'success') {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Changes Saved'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ]));
                    }
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
