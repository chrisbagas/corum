import 'package:flutter/material.dart';
import 'screens/forum_home_page.dart';

// import 'package:timeago/timeago.dart' as timeago;

// import '';
// import 'models/forum.dart';
// import 'dummy_data.dart';

void main() {
  runApp(const ForumHomePage());
}

class ForumHomePage extends StatelessWidget {
  const ForumHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum Corum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ForumHome(),
    );
  }
}


/*

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final List<Forum> _forumList = DUMMY_FORUMS;

  Widget _buildForumCard(forum) {
    // const int maxChar = 11;
    return Card(
      margin: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 0),
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CircleAvatar(
                  child: Text(
                    forum.author[0],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      forum.title,
                      // forum.title.toString().length > maxChar
                      //     ? forum.title.toString().substring(0, maxChar) +
                      //         " ..."
                      //     : forum.title.toString(),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'posted by ${forum.author} ${timeago.format(forum.modifiedTime)}',
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
                  children: const [
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 38,
                    //       child: TextButton(
                    //         onPressed: () {},
                    //         child: const Icon(
                    //           Icons.delete,
                    //           color: Colors.red,
                    //           size: 20.0,
                    //           semanticLabel: 'Delete',
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 38,
                    //       child: TextButton(
                    //         onPressed: () {},
                    //         child: const Icon(
                    //           Icons.edit,
                    //           color: Colors.green,
                    //           size: 20.0,
                    //           semanticLabel: 'Edit',
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    Text('0 reply'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ini Forum'),
      ),
      body: Center(
        child: ListView(
          children: _forumList.map((forum) => _buildForumCard(forum)).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
*/