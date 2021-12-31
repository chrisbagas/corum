import 'package:flutter/material.dart';
import 'widgets/index_page.dart';

class Blog extends StatelessWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloggers',
      theme: ThemeData(
        primaryColor: Colors.amber,
        canvasColor: const Color(0xFF0F170F), // F2EFE8
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x80FFFFFF),
              style: BorderStyle.solid,
              width: 12,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF2C2E3D),
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x8060FF6E),
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: const TextStyle(
            color: Color(0xFFF2F8F2),
          ),
          hintStyle: const TextStyle(
            color: Color(0x60F2F8F2),
          ),
          counterStyle: const TextStyle(
            color: Color(0xFFF2F8F2),
          ),
        ),
        textTheme: const TextTheme(
          headline4: TextStyle(
            color: Color(0xFFF2F8F2), // 080405
            fontSize: 24,
            fontFamily: 'Playfair Display',
            fontWeight: FontWeight.w400,
          ),
          headline5: TextStyle(
            color: Color(0xFFE6F8F2), // 0F0802
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),
          headline6: TextStyle(
            color: Color(0xFF262822),
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
          ),
          subtitle1: TextStyle(
            color: Color(0xFFE6F8F2),
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
          ),
          bodyText1: TextStyle(
            color: Color(0xFFF2F8F2),
            fontSize: 14,
            fontFamily: 'PT Serif',
            fontWeight: FontWeight.normal,
          ),
          caption: TextStyle(
            color: Color(0xC0E6F8F2),
            fontSize: 10,
            fontFamily: 'Lato',
            fontWeight: FontWeight.normal,
          ),
          button: TextStyle(
            color: Color(0xC0E6F8F2),
            fontSize: 14,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
          ),
        ),
        primarySwatch: Colors.green,
      ),
      home: const IndexPage(),
    );
  }
}
