import 'package:corum/event/Screens/card.dart';
import 'package:flutter/material.dart';
import 'package:corum/event/Screens/detail_screen.dart';
import 'package:corum/event/Screens/form.dart';
import 'package:corum/event/models/events.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final event = fetchPosts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Event"),
          backgroundColor: Colors.greenAccent.shade200,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => formstateful()),
                );
              },
              icon: const Icon(Icons.add_sharp),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false, // set it to false
        body: SingleChildScrollView(child: Cardlist(event: event)));
  }
}
