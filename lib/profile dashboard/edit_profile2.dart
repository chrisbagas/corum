// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:corum/api/GetCookies.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'widgets/textfield_widget.dart';
import 'profile.dart';

class EditProfilePageNoPic extends StatefulWidget {
  @override
  State<EditProfilePageNoPic> createState() => _EditProfilePageNoPicState();
}

class _EditProfilePageNoPicState extends State<EditProfilePageNoPic> {
  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String email = '';
  String bio = '';

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
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.all(8.0), child: buildFirstName()),
              Padding(
                  padding: const EdgeInsets.all(8.0), child: buildLastName()),
              Padding(padding: const EdgeInsets.all(8.0), child: buildBio()),
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
                    print('cekk: ' + firstName + lastName + bio);
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final response = await http.post(
                          Uri.parse(
                              "https://corum.herokuapp.com/profile/edit/flutter/nopic"),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'firstName': firstName,
                            'lastName': lastName,
                            'username': username,
                            'bio': bio,
                          }));
                      Map<String, dynamic> extractedData =
                          jsonDecode(response.body);
                      String status = extractedData['status'];
                      //munculin popup
                      if (status == 'success') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Profil updated!"),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Ups, terjadi kesalahan!"),
                        ));
                      }
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

  Widget buildFirstName() => TextFormField(
      decoration: new InputDecoration(
        labelText: "Nama Depan",
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      onSaved: (value) => setState(() => firstName = value!));
  Widget buildLastName() => TextFormField(
      decoration: new InputDecoration(
        labelText: "Nama Belakang",
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      onSaved: (value) => setState(() => lastName = value!));
  Widget buildBio() => TextFormField(
      decoration: new InputDecoration(
        labelText: "Bio",
        border:
            OutlineInputBorder(borderRadius: new BorderRadius.circular(5.0)),
      ),
      onSaved: (value) => setState(() => bio = value!));
}
