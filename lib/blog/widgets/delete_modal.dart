import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';

class DeleteModal extends StatefulWidget {
  const DeleteModal({
    Key? key,
    required this.slug,
  }) : super(key: key);

  final String slug;

  @override
  _DeleteModalState createState() => _DeleteModalState();
}

class _DeleteModalState extends State<DeleteModal> {
  @override
  Widget build(BuildContext context) {
    final _request = context.watch<ConnectNetworkService>();
    return AlertDialog(
      content: const Text(
        "You're about to delete one of your posts. Are you sure you want to proceed?",
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            await _request.post(
              'https://corum.herokuapp.com/blog/${widget.slug}/delete-post/',
              null,
            );
            Navigator.pop(context, true);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
