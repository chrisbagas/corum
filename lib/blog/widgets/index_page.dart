import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';

import './card_list.dart';
import './search_bar.dart';
import './post_form.dart';
import '../models/post.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final Future<List<Post>> posts = fetchPosts();

  @override
  Widget build(BuildContext context) {
    final _request = context.watch<ConnectNetworkService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        backgroundColor: Colors.greenAccent.shade200,
        titleTextStyle: const TextStyle(
          color: Color(0xFFE6F8F2),
          fontSize: 18,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
        ),
        //systemOverlayStyle: const SystemUiOverlayStyle(
        //  statusBarColor: Color(0x00000000),
        //  systemNavigationBarColor: Color(0xFF000000),
        //),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchPost(posts: posts),
              );
            },
            icon: const Icon(Icons.search),
          ),
          Visibility(
            visible: _request.loggedIn,
            child: IconButton(
              // TODO refresh page if possible
              onPressed: () async {
                if (await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PostForm()),
                    ) ==
                    true) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.add_circle_outline_sharp),
            ),
          ),
        ],
      ),
      body: Center(
        child: CardList(posts: posts),
      ),
    );
  }
}
