import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:forum_corum/forum/models/forum_model.dart';
import 'dart:convert';

class ForumForm extends StatefulWidget {
  const ForumForm({Key? key}) : super(key: key);
  static const routeName = '/create';

  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final _key = GlobalKey<FormState>();
  String _title = "";
  String _body = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new forum'),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Write the title for your forum post here.',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid title.";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    maxLines: 12,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Body',
                      hintText: 'Write your forum here.',
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _body = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _body = value!;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid body.";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      // const url = 'http://localhost:8000/forum/api';
                      // final response = await http.post(
                      //   Uri.parse(url),
                      //   body: convert. {
                      //     "title": _title,
                      //     "body": _body,
                      //     "author": "author"
                      //   },
                      // );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('New forum is created!')),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
