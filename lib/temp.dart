import 'package:flutter/material.dart';

class Temp extends StatelessWidget {
  const Temp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("temp"),
        backgroundColor: Colors.greenAccent.shade200,
      ),
      body: const Text("temp"),
    );
  }
}
