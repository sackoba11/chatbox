import 'dart:async';
import 'package:chatbox/pages/login.dart';
import 'package:chatbox/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    setState(() {});
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("utilisateur est déconnecté !");
        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login1())));
      } else {
        print("utilisateur est connecté sur Welcome!");
        print("voici son uid: ${user.uid}");
        Timer(
            const Duration(seconds: 1),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreens())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GFLoader(type: GFLoaderType.ios),
      ),
    );
  }

  loading(context) => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            ),
          ));
}
