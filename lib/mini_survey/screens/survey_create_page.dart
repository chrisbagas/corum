import 'package:flutter/material.dart';

import '../widgets/text_form_field.dart';

class SurveyCreatePage extends StatefulWidget {
  const SurveyCreatePage({ Key? key }) : super(key: key);

  @override
  _SurveyCreatePageState createState() => _SurveyCreatePageState();
}

class _SurveyCreatePageState extends State<SurveyCreatePage> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create New Survey'),
        backgroundColor: Colors.greenAccent.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 56.0),
        child: Container(
          height: 550,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 26.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 3,
              )
            ]
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Survey Form',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 2,
                  width: 140,
                  color: Colors.green,
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      buildTextFormField('Title', Icons.subject_rounded),
                      buildTextFormField('Description', Icons.description),
                      buildTextFormField('Option 1', Icons.add_box_outlined),
                      buildTextFormField('Option 2', Icons.add_box_outlined)
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  child: const Text('Create'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}