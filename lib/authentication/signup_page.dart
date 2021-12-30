import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:corum/api/GetCookies.dart';
import 'package:corum/authentication/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const routeName = '/signup_page';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String email = "";
  String password1 = "";
  String password2 = "";
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<ConnectNetworkService>();
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.width * 0.4,
                  ),
                  const Text('Register Account',
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "username",
                            labelText: "Username",
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              username = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "text@mail.com",
                            labelText: "Email",
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              email = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              email = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isHidden,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                              icon: isHidden
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              password1 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              password1 = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isHidden,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Confirm Password",
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: isHidden
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isHidden = !isHidden;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              password2 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              password2 = value!;
                            });
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: size.height * 0.075,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFF293241),
                        ),
                        child: TextButton.icon(
                          icon: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Submit to Django server and wait for response
                              final response = await request.postJson(
                                  "https://corum.herokuapp.com/signupflutter/",
                                  convert.jsonEncode(<String, String>{
                                    'username': username,
                                    'email': email,
                                    'password1': password1,
                                    'password2': password2,
                                  }));
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Account has been successfully registered!"),
                                ));
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "An error occured, please try again."),
                                ));
                              }
                            }
                          },
                          label: const Icon(Icons.arrow_right, size: 40),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 22,
                                color: Colors.white,
                                height: 1.5),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 22,
                                  color: Colors.white,
                                  height: 1.5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
