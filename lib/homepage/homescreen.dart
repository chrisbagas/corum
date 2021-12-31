import 'package:flutter/material.dart';
import 'feedback_form.dart';
import 'package:provider/provider.dart';
import 'package:corum/api/GetCookies.dart';
import 'package:corum/authentication/signup_page.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.light,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  String about =
      'Platform (Website) ini merupakan sarana bagi orang-orang yang ingin berbagi cerita seputar Covid-19. Baik membagikan pengalaman jika pernah terjangkit covid-19 sebelumnya, pengalaman yang dirasakan ketika melakukan vaksin, serta hal-hal apapun yang merupakan dampak dari pandemi covid ini. Selain itu, platform ini juga menyediakan forum bagi pengguna yang memiliki pertanyaan seputar covid-19 dimana pertanyaan tersebut bisa dijawab oleh pengguna lain yang sekiranya tahu atau pernah mengalami apa yang ditanyakan tersebut.';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();
    final _username = request.username;
    String greet = "";

    String printUsername(greet) {
      if (request.loggedIn) {
        greet = 'Hello, ' + _username + '\nWelcome back\nCORUM\nShare With Us';
      } else {
        greet = 'Hello, Welcome to our Apps\nCORUM\nShare With Us';
      }
      return greet;
    }

    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.greenAccent.shade200,
          title: Text(
            'Corum',
          ),
        ),
        body: ListView(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Text(
                      printUsername(greet),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    alignment: Alignment.center,
                    width: 600,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                      ),
                      color: Colors.greenAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(20.0),
                  ),
                  Container(
                    child: Text(
                      about,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    alignment: Alignment.center,
                    width: 600,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        // color: const Color(0xFFC2FFD9),
                        color: Colors.greenAccent,
                      ),
                      // color: const Color(0xFFC2FFD9),
                      color: Colors.greenAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  ),
                  SizedBox(
                      height: 50, //height of button
                      width: 150, //width of button
                      child: ElevatedButton(
                        onPressed: () {
                          if (request.loggedIn) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BelajarForm()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "You must be signed in if you want to give the feedback, you will be redirected to Sign Up Page"),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          }
                        },
                        child: Text("Feedback Form",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                        style: ElevatedButton.styleFrom(
                          // primary: const Color(0xFFC2FFD9),
                          primary: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(20)),
                          shadowColor: Colors.black,
                        ),
                        //parameters of Button class
                      )),
                ])
          ],
        ));
  }
}
