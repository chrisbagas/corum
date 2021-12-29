import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);
  static const routeName = '/signup_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 200,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 450,
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5)
                  ]),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: const <Widget>[
                          Text(
                            "REGISTER ACCOUNT",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'DMSans',
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        _buildTextFields(Icons.account_box_outlined, "Username",
                            false, false),
                        _buildTextFields(
                            Icons.email_outlined, "Email", false, true),
                        _buildTextFields(
                            Icons.lock_outline, "Password", true, false),
                        _buildTextFields(Icons.lock_outline, "Confirm Password",
                            true, false),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).secondaryHeaderColor,
                      fixedSize: const Size(240, 50),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                          fontFamily: 'DMSans',
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      const snackBar = SnackBar(
                        content: Text('Create Account Succesful'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: const Text(
                      "Create Account",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_page');
                      },
                      child: const Text(
                        "log in",
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 22,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFields(
      IconData icon, String hintTexts, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(35)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black45),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hintTexts,
            hintStyle: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
