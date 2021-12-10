import 'package:flutter/material.dart';
import './card_item.dart';
import '../models/post.dart';

class CardList extends StatefulWidget {
  const CardList({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final Future<List<Post>> posts;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: widget.posts,
      builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Nothing Found :(',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }

          return ListView(
            children: snapshot.data!.map<Widget>((post) {
              return CardItem(post: post);
            }).toList(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
