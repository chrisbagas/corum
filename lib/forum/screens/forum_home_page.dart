import 'package:flutter/material.dart';
import 'package:corum/forum/screens/create_forum.dart';
import 'package:corum/forum/widgets/forum_card_list.dart';
import 'package:corum/forum/models/forum_model.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';

class ForumHome extends StatefulWidget {
  const ForumHome({Key? key}) : super(key: key);

  // static const routeName = '/forum';

  @override
  _ForumHomeState createState() => _ForumHomeState();
}

class _ForumHomeState extends State<ForumHome> {
  Future<List<Forum>> forums = fetchForums();

  _navigateAndRefresh(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForumForm()),
    );

    if (result) {
      setState(() {
        forums = fetchForums();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();
    final _username = request.username;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forum"),
        backgroundColor: Colors.greenAccent.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Center(
          child: CardList(forums: forums, username: _username),
        ),
      ),
      floatingActionButton: Visibility(
        visible: request.loggedIn,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ForumForm())).then((value) {
              //   setState(() {});
              // });
              _navigateAndRefresh(context);
            },
            tooltip: 'Add forum',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
