import 'package:chatbox/animation/FadeAnimation.dart';
import 'package:chatbox/pages/forgotpass.dart';
import 'package:chatbox/pages/signup.dart';
import 'package:chatbox/screens/screens.dart';
import 'package:flutter/material.dart';

class Login1 extends StatefulWidget {
  const Login1({super.key});

  @override
  State<Login1> createState() => _Login1State();
}

class _Login1State extends State<Login1> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(

        //backgroundColor: Colors.white, //Colors.white,
        body: Card(
      margin: const EdgeInsets.all(0),
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      child: SingleChildScrollView(
        child: Container(
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
                                    image:
                                        AssetImage('images/images/clock.png'))),
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
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or Phone number",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
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
                        onTap: (() {
                          var route = MaterialPageRoute(
                              builder: (BuildContext context) => HomeScreen());
                          Navigator.of(context).push(route);
                        }),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
