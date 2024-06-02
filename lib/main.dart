import 'dart:developer';

import 'package:ecommerce_application/provider/cartprovider.dart';
import 'package:ecommerce_application/screens/homepage.dart';
import 'package:ecommerce_application/webservices/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
    log("isloggedin = " + isLoggedIn.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn == true ? const HomePage() : const LoginPage());
  }
}
