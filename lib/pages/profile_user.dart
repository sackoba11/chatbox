import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  bool val = false;

  late MyUser me;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _getUser();
    });
  }

  void change(bool index) {
    setState(() {
      val = index;
    });
  }

  _getUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
        print("me----${me.uid}");
        print("me----${me.nom}");
        print("me----${me.prenoms}");
        print("me----${me.initiales}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
          titleTextStyle: Theme.of(context).textTheme.headline6,
        ),
        body: Stack(fit: StackFit.passthrough, children: [
          ListView(children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.0),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("images/1.jpg"),
                      ),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(hintText: me.nom),
                ),
                TextField(
                  decoration: InputDecoration(hintText: me.prenoms),
                ),
                const Text(
                  "+22555324247",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Notifications en mode silence"),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Switch(
                                value: val,
                                onChanged: change,
                                activeColor:
                                    const Color.fromRGBO(143, 148, 251, 1),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(Icons.block),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (() {}),
                                child: const Text("Bloquer sacko"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(Icons.thumb_down),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (() {}),
                                  child: const Text("Signler Sacko"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ])
          ]),
        ]));
  }
}
