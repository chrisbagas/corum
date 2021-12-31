import 'package:flutter/material.dart';
import 'package:corum/forum/screens/forum_detail_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:corum/forum/models/forum_model.dart';

@immutable
class CardItem extends StatefulWidget {
  const CardItem({
    Key? key,
    required this.forum,
    required this.username,
  }) : super(key: key);

  final Forum forum;
  final String username;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _showDetailButton = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 0),
      child: InkWell(
        onTap: () {
          setState(() => _showDetailButton = !_showDetailButton);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForumDetailPage()),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CircleAvatar(
                  child: Text(
                    widget.forum.authorUsername[0],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.forum.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'posted by ${widget.forum.authorUsername.toString().toUpperCase()} - ${timeago.format(widget.forum.modifiedTime)}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0, right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Visibility(
                          visible: (widget.username ==
                                  widget.forum.authorUsername) &&
                              widget.forum.authorUsername,
                          child: SizedBox(
                            width: 38,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Coming soon')),
                                );
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20.0,
                                semanticLabel: 'Delete',
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: (widget.username ==
                                  widget.forum.authorUsername) &&
                              widget.forum.authorUsername,
                          child: SizedBox(
                            width: 38,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Coming soon')),
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.green,
                                size: 20.0,
                                semanticLabel: 'Edit',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text('0 reply'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
