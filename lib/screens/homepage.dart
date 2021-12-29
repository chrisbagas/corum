import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          centerTitle: true,
          title: const Text(
            'Hi, Rafi',
            style: TextStyle(
              fontFamily: 'DMSans',
              fontSize: 28,
              color: Colors.blue,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const <Widget>[Text("test")],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 2,
          child: const Icon(Icons.add),
          onPressed: () => {},
          backgroundColor: const Color.fromRGBO(11, 128, 236, 1),
        ));
  }
}
