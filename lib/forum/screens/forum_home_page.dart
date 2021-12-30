import 'package:flutter/material.dart';
import 'package:forum_corum/forum/screens/create_forum.dart';
import 'package:forum_corum/forum/widgets/forum_card_list.dart';
import 'package:forum_corum/forum/models/forum_model.dart';
// import 'package:forum_corum/forum/models/forum_model_alt.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({Key? key}) : super(key: key);
  static const routeName = '/forum';

  @override
  _ForumHomeState createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  final Future<List<Forum>> forums = fetchForums();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
      ),
      body: Center(
        child: CardList(forums: forums),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForumForm()),
          );
        },
        tooltip: 'Add forum',
        child: const Icon(Icons.add),
      ),
    );
  }
}
