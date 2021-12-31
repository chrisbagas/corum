import 'dart:convert' as convert;
import 'package:corum/homepage/feedback_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';

void main() {
  runApp(MaterialApp(
    title: "Belajar Form Flutter",
    home: BelajarForm(),
  ));
}

class BelajarForm extends StatefulWidget {
  @override
  _BelajarFormState createState() => _BelajarFormState();
}

class _BelajarFormState extends State<BelajarForm> {
  final _formKey = GlobalKey<FormState>();
  FeedbackModels? feedback;
  String pesan = "";
  String nilai = "";

  double nilaiSlider = 1;
  static const IconData messages =
      IconData(0xe3e0, fontFamily: 'MaterialIcons');
  String result = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();
    return Scaffold(
      backgroundColor: const Color(0xFF65CCB8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xAAC1FFD7),
        centerTitle: true,
        title: Text(
          "Feedback Form",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: new InputDecoration(
                        hintText: "Write your feeling about our web",
                        labelText: "Messages",
                        icon: Icon(messages),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pesan tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: ((value) => setState(() => pesan = value!)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: new InputDecoration(
                        labelText: "Rating",
                        hintText: "Enter Rating: only numbers from 0-5",
                        icon: Icon(Icons.star),
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Masukan harus berupa angka';
                        } else if (int.parse(value) > 5 ||
                            int.parse(value) < 0) {
                          return "Only from 0-5";
                        } else {
                          return null;
                        }
                      },
                      onSaved: ((value) => setState(() => nilai = value!)),
                    ),
                  ),

                  ElevatedButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(15)),
                      shadowColor: Colors.black,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final response = await request.post(
                            "https://corum.herokuapp.com/feedback/post/",
                            convert.jsonEncode(<String, String>{
                              'message': pesan,
                              'rating': nilai
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Thanks for submitting your review about our apps"),
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("An error occured, please try again."),
                          ));
                        }
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                  ),
                  ElevatedButton(
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(15)),
                      shadowColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // Text((feedback != null)
                  //     ? feedback!.message + " " + feedback!.rating
                  //     : "Tidak ada data"
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
