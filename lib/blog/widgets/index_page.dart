import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PostForm()),
              );
            },
            icon: const Icon(Icons.add_sharp),
          ),
        ],
      ),
      body: Center(
        child: CardList(posts: posts),
      ),
    );
  }
}
