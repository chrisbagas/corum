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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: Text(
                  widget.forum.title,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.left,
                  softWrap: true,
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'posted by ${widget.forum.authorUsername.toString().toUpperCase()} - ${timeago.format(widget.forum.modifiedTime)}',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                          Text(
                            widget.forum.body,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                child: TextFormField(
                  enabled: _request.loggedIn,
                  style: Theme.of(context).textTheme.subtitle2,
                  decoration: InputDecoration(
                    labelText: 'Answer',
                    hintText: 'Write your answer here',
                    // border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {},
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
    );
  }
}
