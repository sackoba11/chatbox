import 'package:chatbox/animation/FadeAnimation.dart';
import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/login.dart';
import 'package:chatbox/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nomUser = TextEditingController();
  final numero = TextEditingController();
  final newemailtextcontroller = TextEditingController();
  final newpasswordcontroller = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
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
                height: MediaQuery.of(context).size.height / 2.5, //390,
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
                      ),
                    ),
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
                                    image:
                                        AssetImage('images/images/clock.png'))),
                          )),
                    ),
                    Positioned(
                      child: FadeAnimation(
                          1.6,
                          Container(
                            margin: const EdgeInsets.only(top: 115),
                            child: Center(
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                    color: (brightness == Brightness.light)
                                        ? Colors.white
                                        : Colors.grey[400],
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
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.8,
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: (brightness == Brightness.light)
                                ? Colors.white
                                : Colors.grey[700],
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
                              height: h / 13,
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: nomUser,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Full name",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              height: h / 13,
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: numero,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Numéro",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              height: h / 13,
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: newemailtextcontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              height: h / 13,
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: newpasswordcontroller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 40,
                    ),
                    FadeAnimation(
                      2,
                      InkWell(
                        onTap: creationUser,
                        child: Container(
                          height: h / 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: const Center(
                            child: Text(
                              "Create Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 125,
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        child: const Text(
                          "OR",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        )),
                    SizedBox(
                      height: h / 125,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: MaterialButton(
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30.0,
                                  width: 30.0,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/goole.png'),
                                        fit: BoxFit.cover),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text("Sign in with Google",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            // by onpressed we call the function signup function
                            onPressed: () {
                              FirebaseHelper().gSignin();
                              if (user != null) {
                                setState(() {
                                  var route = MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  );
                                  Navigator.of(context).push(route);
                                });
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: h / 50,
                    ),
                    FadeAnimation(
                      2.5,
                      InkWell(
                        onTap: (() {
                          var route = MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Login1());
                          Navigator.of(context).push(route);
                        }),
                        child: const Text(
                          "Do you have an account? Connect",
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  // function to implement the google signin

// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signup() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential

      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      // if (result != null) {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // } // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }

  creationUser() {
    if (nomUser.text != " ") {
      if (numero.text != " ") {
        if (newemailtextcontroller.text != " ") {
          if (newpasswordcontroller.text != " ") {
            FirebaseHelper()
                .create(newemailtextcontroller.text, newpasswordcontroller.text,
                    numero.text, nomUser.text)
                .then((value) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreens())));
          } else {
            debugPrint("saisissez votre mot de passe!");
          }
        } else {
          debugPrint("saisissez votre email!");
        }
      } else {
        debugPrint("saisissez votre prenom!");
      }
    } else {
      debugPrint("saisissez votre nom!");
    }
  }
}
