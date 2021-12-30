import 'package:corum/api/GetCookies.dart';
import 'package:corum/authentication/signup_page.dart';
import 'package:corum/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login_page';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String password1 = "";
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
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Flexible(
                    child: Center(
                      child: Text(
                        'CORUM',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 10.0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter your username",
                            labelText: "Username",
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.email),
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
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isHidden,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter your password",
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
                              borderRadius: BorderRadius.circular(15.0),
                            ),
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
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: size.height * 0.075,
                        width: size.width * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFF24262A),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final response = await request.login(
                                "https://corum.herokuapp.com/loginflutter/", {
                              'username': username,
                              'password': password1,
                            });
                            if (response['status']) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Akun telah berhasil masuk!"),
                              ));
                              Navigator.pushReplacementNamed(
                                  context, MyHomePage.routeName); // buat navigasi ke home
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("An error occured, please try again."),
                              ));
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Does not have an account?',
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
                              context, SignUpPage.routeName);
                        },
                        child: const Text(
                          'Sign Up',
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
                    height: 35,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
