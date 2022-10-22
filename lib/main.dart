
import 'package:chatbox/screens/login_page.dart';
import 'package:chatbox/screens/screens.dart';
import 'package:chatbox/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme:ThemeData.dark(),
      themeMode: ThemeMode.dark,
      title: 'ON CAUSE ICI',
      home:  LoginPage(),
      );
      
  }
}

