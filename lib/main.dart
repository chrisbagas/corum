import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:corum/api/GetCookies.dart';
import 'package:corum/authentication/login_page.dart';
import 'package:corum/authentication/signup_page.dart';

import 'blog/blog.dart';
import 'event/Screens/body_home.dart';
import 'temp.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Corum';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
          primaryColor: Color(0xff4FE8B4),
          primarySwatch: Colors.green,
          fontFamily: 'Poppins'),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final screens = [
    temp(),
    Body(),
    temp(),
    blog(),
    temp(),
    temp(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.event, size: 30),
      Icon(Icons.forum, size: 30),
      Icon(Icons.web, size: 30),
      Icon(Icons.how_to_vote, size: 30),
      Icon(Icons.person, size: 30),
    ];
    return Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.white)),
          child: CurvedNavigationBar(
              color: Colors.greenAccent.shade200,
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(microseconds: 500),
              height: 60,
              onTap: (index) => setState(() => this.index = index),
              items: items),
        ));
  }
}
