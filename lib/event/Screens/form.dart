import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

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

  // void openFile(PlatformFile file){
  //   OpenFile.open(file.path);
  // }
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

  String Title = '';
  String date = '';
  String time = '';
  String media = '';
  String url = '';
  String description = '';
  File? image1;
  File? image2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Title",
                    icon: Icon(Icons.textsms_outlined),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Title tidak boleh kosong';
                      }
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
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
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Media",
                    icon: Icon(Icons.tv),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Media tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Description",
                    icon: Icon(Icons.text_snippet),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Description tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(
                child: Text(
                  "Pick Thumbnail",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  pickImage();
                },
              ),
              RaisedButton(
                child: Text(
                  "Pick Page Image",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  pickImage2();
                },
              ),
              RaisedButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    _formKey.currentState!.save();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
