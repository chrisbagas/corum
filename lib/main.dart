import 'package:corum/api/GetCookies.dart';
import 'package:corum/screens/homepage.dart';
import 'package:corum/screens/login_page.dart';
import 'package:corum/screens/signup_page.dart';
import 'package:corum/screens/starting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        ConnectNetworkService request = ConnectNetworkService();

        return request;
      },
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'DMSans',
          primaryColor: const Color.fromRGBO(101, 204, 184, 1),
          secondaryHeaderColor: const Color.fromRGBO(79, 232, 180, 1),
        ),
        title: 'Corum App',
        home: const StartingPage(),
        routes: {
          SignUpPage.routeName: (ctx) => const SignUpPage(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          HomePage.routeName: (ctx) => const HomePage(),
        },
      ),
    );
  }
}
