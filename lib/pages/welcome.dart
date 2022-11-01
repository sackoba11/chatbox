import 'dart:async';
import 'dart:io';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/login.dart';
import 'package:chatbox/pages/profil_page.dart';
import 'package:chatbox/screens/home_screen.dart';
import 'package:chatbox/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final User? user = FirebaseAuth.instance.currentUser;
  late MyUser me;
  static final entryPoint = FirebaseDatabase.instance.ref();
  static final userEntry = entryPoint.child("users");

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("utilisateur est non connecté !");
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
                MaterialPageRoute(builder: (context) => HomeScreen())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        "Chargement en cours....!",
        style: TextStyle(
          fontSize: 20.0,
          color: AppColors.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
