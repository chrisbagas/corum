import 'package:corum/event/Screens/card.dart';
import 'package:flutter/material.dart';
import 'package:corum/event/Screens/detail_screen.dart';
import 'package:corum/event/Screens/form.dart';
import 'package:corum/event/models/events.dart';
import 'package:corum/api/GetCookies.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<List<Events>> event = fetchPosts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Event",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [buildButton(context)]),
        resizeToAvoidBottomInset: false, // set it to false
        body: Center(
            child: SingleChildScrollView(child: Cardlist(event: event))));
  }

  Widget buildButton(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();
    if (request.username == 'c08') {
      return IconButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => formstateful()),
          );
          setState(() {
            event = fetchPosts();
          });
        },
        icon: const Icon(Icons.add_sharp),
      );
    } else {
      return Container();
    }
  }
}
