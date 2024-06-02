import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_application/webservices/webservices.dart';
import 'package:ecommerce_application/webservices/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  String? name, phoneNumber, email, address, username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> registration(
      String name, phoneNumber, email, address, username, password) async {
    try {
      var result;

      print("name =" + name.toString());
      print("phone =" + phoneNumber.toString());
      print("address =" + address.toString());
      print("username =" + username.toString());
      print("password =" + password.toString());

      final Map<String, dynamic> data = {
        'name': name.toString(),
        'phone': phoneNumber.toString(),
        'address': address.toString(),
        'username': username.toString(),
        'password': password.toString(),
      };
      final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/registration.php"),
        body: data,
      );
      print(response.statusCode.toString());
      print(response.body);

      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          log("registration successfully completed");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              content: Text(
                "REGISTRATION SUCCESSFULLY COMPLETED!!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return LoginPage();
            }),
          );
        } else {
          log("registration failed");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              content: Text(
                "REGISTRATION FAILED!!!",
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
        child: Column(
          children: [
            const SizedBox(height: 100.0),
            const Text(
              'Register Account',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            const Text(
              'Complete your details',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your name';
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
                            onChanged: (text) {
                              setState(() {
                                phoneNumber = text;
                              });
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter phone";
                              } else if (value.length != 10) {
                                return "Please enter valid phone number";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Phone',
                            ),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                address = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Address',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your address';
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                username = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Username',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your username';
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      log("hai");
                      if (_formKey.currentState!.validate()) {
                        log("name =" + name.toString());
                        log("phone =" + phoneNumber.toString());
                        log("address =" + address.toString());
                        log("username =" + username.toString());
                        log("password =" + password.toString());
                        registration(name!, phoneNumber, email, address,
                            username, password);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 110.0, vertical: 15.0),
                      backgroundColor: Colors.blueGrey,
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
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
          ],
        ),
      ),
    );
  }
}
