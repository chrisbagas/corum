import 'package:flutter/material.dart';

class temp extends StatelessWidget {
  const temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("temp"),
        backgroundColor: Colors.greenAccent.shade200,
      ),
      body: Text("temp"),
    );
  }
}
