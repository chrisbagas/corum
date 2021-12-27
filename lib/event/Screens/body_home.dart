import 'package:flutter/material.dart';
import 'package:corum/event/Screens/detail_screen.dart';
import 'package:corum/event/Screens/form.dart';
import 'package:corum/event/models/events.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  final event = events;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xffC1FFD7),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: event.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "EVENTS SEPUTAR ",
                            style: TextStyle(fontSize: 45),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "COVID-19",
                                  style: TextStyle(
                                      fontSize: 45,
                                      color: Colors.amber.shade600,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                "Ikuti event-event untuk menambah wawasan seputar ",
                            style: TextStyle(fontSize: 30),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "COVID-19",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.amber.shade600,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )),
                    RaisedButton(
                        child: Text(
                          "Add Event",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          fetchData();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => formstateful(),
                          //     ));
                        })
                  ],
                );
              } else {
                return Card(
                  shadowColor: Colors.red,
                  elevation: 8,
                  color: Theme.of(context).primaryColor,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(),
                          settings: RouteSettings(arguments: event[index]),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Ink.image(
                          image: AssetImage(
                            event[index].image,
                          ),
                          height: 300,
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              event[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(event[index].date,
                                textAlign: TextAlign.start)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(event[index].time,
                                textAlign: TextAlign.start)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Text(event[index].media,
                                textAlign: TextAlign.start)),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}

Future<void> fetchData() async {
  const url = 'http://127.0.0.1:8000/event/json';

  try {
    final response = await http.get(Uri.parse(url));

    List<dynamic> extractedData = jsonDecode(response.body);

    extractedData.forEach((val) {
      print(val);
    });
  } catch (error) {
    print(error);
  }
}
