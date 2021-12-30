// import 'package:flutter/material.dart';

// import 'forum.dart';

// class ForumApp extends StatelessWidget {
//   const ForumApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Forum',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: const ForumScreen(),
//       initialRoute: '/',
//       onGenerateRoute: _getRoute,
//     );
//   }
// }

// Route<dynamic>? _getRoute(RouteSettings settings) {
//   if (settings.name != '/forum') return null;

//   return MaterialPageRoute<void>(
//     settings: settings,
//     builder: (BuildContext context) => const ForumApp(),
//     fullscreenDialog: true,
//   );
// }
