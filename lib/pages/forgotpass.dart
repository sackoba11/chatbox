import 'package:chatbox/animation/FadeAnimation.dart';
import 'package:chatbox/firebase.dart';
import 'package:chatbox/pages/signup.dart';
import 'package:chatbox/screens/screens.dart';
import 'package:chatbox/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final auth = FirebaseAuth.instance;
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      child: SingleChildScrollView(
        child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
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
                            margin: const EdgeInsets.only(top: 90),
                            child: Center(
                              child: Text(
                                "Reset your password",
                                style: TextStyle(
                                    color: (brightness == Brightness.light)
                                        ? Colors.white
                                        : Colors.grey[400],
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                      1.7,
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
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: email,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 10,
                    ),
                    FadeAnimation(
                      1.8,
                      InkWell(
                        onTap: () async {
                          bool send =
                              await FirebaseHelper().resetpassword(email.text);
                          if (send) {
                            confirm();
                          } else {
                            avertissement();
                          }
                        },
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
                              "Send",
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
                    SizedBox(
                      height: h / 10,
                    ),
                    FadeAnimation(
                      2.0,
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> confirm() async {
    Text content = const Text(
        "Veuillez consulter votre compte mail pour confirmer le nouveau mot de passe !!. Vérifiez le spam également!!!");
    ElevatedButton ok = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("OK"),
    );

    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  content: content,
                  actions: <Widget>[ok],
                )
              : AlertDialog(
                  content: content,
                  actions: <Widget>[ok],
                );
        });
  }

  Future<void> avertissement() async {
    Text content = const Text("Echec, Veuillez vérifier votre email!!!");
    ElevatedButton ok = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("OK"),
    );

    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  content: content,
                  actions: <Widget>[ok],
                )
              : AlertDialog(
                  content: content,
                  actions: <Widget>[ok],
                );
        });
  }
}
