import 'package:corum/api/GetCookies.dart';
import 'package:corum/forum/models/forum_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumDetailPage extends StatefulWidget {
  const ForumDetailPage({
    Key? key,
    required this.forum,
  }) : super(key: key);

  static const routeName = '/detail';

  final Forum forum;

  @override
  State<ForumDetailPage> createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  final _formKey = GlobalKey<FormState>();
  String _body = '';

  @override
  Widget build(BuildContext context) {
    final _request = context.watch<ConnectNetworkService>();

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.forum.title,
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                ),
                Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CircleAvatar(
                          child: Text(
                            widget.forum.authorUsername[0]
                                .toString()
                                .toUpperCase(),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.forum.authorUsername
                                    .toString()
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              Text(
                                timeago.format(widget.forum.modifiedTime),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: double.infinity,
                          ),
                          Text(
                            widget.forum.body,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const Text("0 Reply"),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    enabled: _request.loggedIn,
                    style: Theme.of(context).textTheme.subtitle2,
                    decoration: InputDecoration(
                      labelText: 'Answer',
                      hintText: 'Write your answer here',
                      // border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Coming soon')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('An error occured')),
                            );
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid answer";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _body = newValue!;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
