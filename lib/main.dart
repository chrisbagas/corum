import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/GetCookies.dart';
import 'authentication/login_page.dart';
import 'authentication/signup_page.dart';
import 'authentication/starting_page.dart';
import 'blog/blog.dart';
import 'event/Screens/body_home.dart';
import 'mini_survey/screens/survey_main_page.dart';
import 'profile dashboard/profile.dart';
import 'temp.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Corum';

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        ConnectNetworkService cookieRequest = ConnectNetworkService();
        return cookieRequest;
      },
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
            primaryColor: Colors.greenAccent.shade200,
            secondaryHeaderColor: const Color.fromRGBO(101, 204, 184, 1),
            primarySwatch: Colors.green,
            fontFamily: 'Poppins'),
        home: const StartingPage(),
        routes: {
          SignUpPage.routeName: (ctx) => const SignUpPage(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          MyHomePage.routeName: (ctx) => MyHomePage(title: appTitle)
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  static const routeName = '/home';
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
    Blog(),
    SurveyMainPage(),
    ProfilePage(),
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
