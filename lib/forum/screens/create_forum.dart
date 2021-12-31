import 'package:corum/api/GetCookies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'package:forum_corum/forum/models/forum_model.dart';
// import 'package:corum/forum/models/forum_model.dart';

class ForumForm extends StatefulWidget {
  const ForumForm({Key? key}) : super(key: key);
  static const routeName = '/create';

  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _body = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a new forum'),
        // backgroundColor: Colors.greenAccent.shade200,
      ),
      body: Form(
        key: _formKey,
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
                      icon: Icon(Icons.text_fields_outlined),
                      alignLabelWithHint: true,
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
                      icon: Icon(Icons.notes),
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
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                          "http://corum.herokuapp.com/forum/create-flutter",
                          convert.jsonEncode(<String, String>{
                            'title': _title,
                            'body': _body,
                          }));

                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('New forum is created!')),
                        );
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('An error has occured.')),
                        );
                      }
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
