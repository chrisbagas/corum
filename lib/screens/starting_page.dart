import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);
  static const routeName = '/starting_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Corum',
              style: GoogleFonts.dmSans(
                fontSize: 64,
                fontWeight: FontWeight.w600,
                textStyle:
                    const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(160, 58),
                shape: const StadiumBorder(),
                primary: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(
                    fontFamily: 'DMSans',
                    fontSize: 28,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('SIGN UP'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(160, 58),
                  shape: const StadiumBorder(),
                  primary: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(10),
                  textStyle: const TextStyle(
                      fontFamily: 'DMSans',
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 28,
                      fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('LOG IN')),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                 Navigator.pushNamed(context, '/home');
              },
              child: const Text(
                'log in as a guest',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
