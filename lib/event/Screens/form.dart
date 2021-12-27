// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

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
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030));
    if (picked != null)
      setState(() => {intialdateval.text = DateFormat.yMd().format(picked)});
  }

  // void openFile(PlatformFile file){
  //   OpenFile.open(file.path);
  // }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        intialtimeval.text = picked_s.format(context);
        selectedTime = picked_s;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corum'),
        backgroundColor: Color(0xffC1FFD7),
        foregroundColor: Colors.black,
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
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Title",
                      icon: Icon(Icons.textsms_outlined),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Title tidak boleh kosong';
                      }
                      return null;
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
                      if (value.isEmpty || value.length < 1) {
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
                      if (value.isEmpty) {
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
                      if (value.isEmpty) {
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
                      if (value.isEmpty) {
                        return 'Description tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                // RaisedButton(
                //   child: Text(
                //     "Pick Image",
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   color: Colors.blue,
                //   onPressed: () {
                //     final result = await FilePicker.platform.pickfiles();
                //     if(result != null) return result;
                //     else return null;

                //     final file = result.files.first;
                //     openFile(file);
                //   },
                // ),
                RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffC1FFD7),
              ),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/corum.png"),
                      backgroundColor: Colors.white,
                      radius: 75.0,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Corum',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      )),
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Forum'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Blog'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Mini Survey'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
