// // main.dart

// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'models/forum.dart';
// // import 'package:timeago/timeago.dart' as timeago;

// // import './screens/tabs_screen.dart';
// // import './screens/forum_screen.dart';
// // import './screens/forum_detail_screen.dart';
// // import './models/forum.dart';
// import './dummy_data.dart';

// void main() => runApp(const ForumApp());

// class ForumApp extends StatefulWidget {
//   const ForumApp({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _ForumAppState();
// }

// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           // The search area here
//           title: Container(
//         width: double.infinity,
//         height: 40,
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(5)),
//         child: Center(
//           child: TextField(
//             decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: () {},
//                 ),
//                 hintText: 'Search...',
//                 border: InputBorder.none),
//           ),
//         ),
//       )),
//     );
//   }
// }

// class _ForumAppState extends State<ForumApp> {
//   final List<Forum> _forumList = DUMMY_FORUMS;
//   // final List<Widget> _widgetOptions = <Widget>[];

//   int _selectedIndex = 0;
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Forum',
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () => Navigator.of(context)
//                   .push(MaterialPageRoute(builder: (_) => const SearchPage())),
//             )
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
//           child: ListView(
//             children: _forumList.map((forum) => _buildForum(forum)).toList(),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Home',
//               backgroundColor: Colors.red,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.forum),
//               label: 'Forum',
//               backgroundColor: Colors.green,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle),
//               label: 'Account',
//               backgroundColor: Colors.purple,
//             ),
//           ],
//           showUnselectedLabels: false,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.teal[800],
//           onTap: _onItemTapped,
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) => _buildPopupDialog(context),
//             );
//           },
//           child: const Icon(Icons.add),
//           backgroundColor: Colors.teal[400],
//           mini: true,
//         ),
//       ),
//     );
//   }

//   Widget _buildPopupDialog(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Popup example'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const <Widget>[
//           Text("Hello"),
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Close'),
//         ),
//       ],
//     );
//   }

//   void testAlert(BuildContext context) {
//     var alert = const AlertDialog(
//       title: Text("Test"),
//       content: Text("Done..!"),
//     );
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return alert;
//         });
//   }

//   Widget _buildForum(forum) {
//     return Card(
//       margin: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0),
//       child: InkWell(
//         splashColor: Colors.teal[50],
//         onTap: () {},
//         child: Column(
//           // mainAxisSize: MainAxisSize.max,
//           children: <Widget>[
//             ListTile(
//               title: Text(
//                 forum.title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 '${forum.author} - ${timeago.format(forum.modifiedTime)}',
//                 style: const TextStyle(
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   TextButton(
//                       onPressed: () {
//                         final snackBar = SnackBar(
//                           content: const Text('Yay! A SnackBar!'),
//                           action: SnackBarAction(
//                             label: 'Undo',
//                             onPressed: () {
//                               // Some code to undo the change.
//                             },
//                           ),
//                         );

//                         // Find the ScaffoldMessenger in the widget tree
//                         // and use it to show a SnackBar.
//                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                       },
//                       child: const Icon(
//                         Icons.edit,
//                         color: Colors.teal,
//                         size: 20.0,
//                         semanticLabel: 'Edit',
//                       )),
//                   TextButton(
//                       onPressed: () {},
//                       child: const Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                         size: 20.0,
//                         semanticLabel: 'Delete',
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
