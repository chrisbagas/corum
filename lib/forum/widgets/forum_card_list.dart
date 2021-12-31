import 'package:flutter/material.dart';
import 'package:corum/forum/widgets/forum_card.dart';

// import '../models/forum_model.dart';
// import 'package:corum/forum/models/forum_model_alt.dart';
import 'package:corum/forum/models/forum_model.dart';

class CardList extends StatefulWidget {
  const CardList({
    Key? key,
    required this.forums,
    required this.username,
  }) : super(key: key);

  final Future<List<Forum>> forums;
  final String username;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forum>>(
      future: widget.forums,
      builder: (context, AsyncSnapshot<List<Forum>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Nothing Found',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return CardItem(
                forum: snapshot.data![index],
                username: snapshot.data![index].authorUsername,
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
