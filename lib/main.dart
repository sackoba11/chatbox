import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'ChatBox',
        home: const SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  // final User? user = FirebaseHelper().auth.currentUser;
  MyUser? me;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Utilisateur courant est déconnecté !');
      } else {
        print('Utilisateur est connecté sur main!');
        print("voici son uid: ${user.uid}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        duration: 500,
        splash: SizedBox(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(4),
                height: 40.5,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "images/logo.png",
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
        backgroundColor: Colors.grey.shade300,
        nextScreen: const Welcome());
  }
}
