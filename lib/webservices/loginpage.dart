import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_application/screens/homepage.dart';
import 'package:ecommerce_application/webservices/signup.dart';
import 'package:ecommerce_application/webservices/webservices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String? username, password;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isloggedin = " + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  login(String username, String password) async {
    try {
      print('webservice');
      print("username =" + username.toString());
      print("password =" + username.toString());

      var result;

      final Map<String, dynamic> loginData = {
        'username': username.toString(),
        'password': password.toString(),
      };

      final response = await http.post(
        Uri.parse(Webservice.mainurl + "login.php"),
        body: loginData,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("login successfully completed");
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isloggedIn", true);
          prefs.setString("username", username);
          print('login successful');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomePage();
            }),
          );
        } else {
          log("login failed");
          ScaffoldMessenger.of(context as BuildContext).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              content: Text(
                "LOGIN FAILED!!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      } else {
        result = {log(json.decode(response.body)['error'].toString())};
      }
      return result;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 150.0),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const Text(
                  "Login with your username and password\n",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Username',
                          ),
                          onChanged: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your username text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          obscureText: true,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Password',
                          ),
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your password text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          log("username = " + username.toString());
                          log("password = " + password.toString());
                          login(username.toString(), password.toString());
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: 'REGISTER HERE',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
