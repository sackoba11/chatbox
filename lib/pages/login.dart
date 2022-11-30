import 'dart:io';
import 'package:chatbox/animation/FadeAnimation.dart';
import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/forgotpass.dart';
import 'package:chatbox/pages/profil_page.dart';
import 'package:chatbox/pages/signup.dart';
import 'package:chatbox/pages/welcome.dart';
import 'package:chatbox/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login1 extends StatefulWidget {
  const Login1({super.key});

  @override
  State<Login1> createState() => _Login1State();
}

class _Login1State extends State<Login1> {
  User? user = FirebaseAuth.instance.currentUser;
  MyUser? me;
  final emailtextcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  String? checkFieldEmpty(String? fieldContent) {
    //<-- add String? as a return type
    if (fieldContent != ' ') {
      return 'Ce champ est obligatoire.';
    }
    return null;
  }

  Future<bool> _onWillPop() async {
    bool value = false;
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("Fermeture"),
            content:
                const Text(" Êtes vous sûr de vouloir quitter l'application ?"),
            actions: <Widget>[
              TextButton(
                  onPressed: (() {
                    setState(() {
                      exit(0);
                    });
                  }),
                  child: const Text("Oui")),
              TextButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: const Text("Non"))
            ],
          );
        });
    return value;
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          //backgroundColor: Colors.white, //Colors.white,
          body: Card(
        margin: const EdgeInsets.all(0),
        color: (brightness == Brightness.light) ? Colors.transparent : null,
        elevation: 0,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          child: Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/images/light-1.png'))),
                            )),
                      )),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.2,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: (brightness == Brightness.light)
                                          ? Colors.white
                                          : Colors.grey[400], //Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1.8,
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: (brightness == Brightness.light)
                                  ? Colors.white
                                  : Colors.grey[700], //Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey))),
                                child: TextFormField(
                                  controller: emailtextcontroller,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                      )),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autofocus: false,
                                  controller: passwordcontroller,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        2,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (() {
                                var route = MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const ForgotPass());
                                Navigator.of(context).push(route);
                              }),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                        2,
                        InkWell(
                          onTap: connexion,
                          // () {
                          //   var route = MaterialPageRoute(
                          //       builder: (BuildContext context) => HomeScreen());
                          //   Navigator.of(context).push(route);
                          // },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                              //tranformer ce login1 en bouton
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: (brightness == Brightness.light)
                                        ? Colors.white
                                        : Colors.grey[400],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      FadeAnimation(
                        2.5,
                        InkWell(
                          onTap: (() {
                            var route = MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SignUp());
                            Navigator.of(context).push(route);
                          }),
                          child: const Text(
                            "Don't have an account? Sign Up ",
                            style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1)),
                          ),
                        ),
                      ),
                      // FloatingActionButton(
                      //   onPressed: () => Future.delayed(
                      //       const Duration(milliseconds: 1000), () {
                      //     //exit(0);
                      //     SystemChannels.platform
                      //         .invokeMethod('SystemNavigator.pop');
                      //   }),
                      //   tooltip: 'Close app',
                      //   child: new Icon(Icons.close),
                      // ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  _getUser() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
  }

  connexion() {
    if (emailtextcontroller.text != " ") {
      if (passwordcontroller.text != " ") {
        FirebaseHelper()
            .handleSignIn(emailtextcontroller.text, passwordcontroller.text)
            .then((user) {
          //print('user--$user');

          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => HomeScreens()));
        });
      } else {
        debugPrint("mot de passe vide");
      }
    } else {
      debugPrint("email vide");
    }
  }
}
