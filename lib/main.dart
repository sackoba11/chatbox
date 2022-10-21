import 'package:chatbox/pages/login1.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    //required this.client
  });

  //final StreamChatClient client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.light(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        title: 'ChatBox',
        home: const SplashScreen());
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 600,
        splash: SizedBox(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                height: 40.5,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/logo.png",
                      ),
                    )),
              ),
              const Text(
                "ChatBox",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: Colors.white10,
        nextScreen: const Login1());
  }
}
