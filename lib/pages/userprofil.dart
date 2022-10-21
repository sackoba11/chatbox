import 'package:flutter/material.dart';

class Profileuser extends StatefulWidget {
  const Profileuser({super.key});

  @override
  State<Profileuser> createState() => ProfileuserState();
}

class ProfileuserState extends State<Profileuser> {
  bool val = false;

  void change(bool index) {
    setState(() {
      val = index;
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
                        radius: 100,
                        backgroundImage: AssetImage("assets/images/3.jpg"),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Christophe J-B KONATE",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "+2250778350601",
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
                      child: Icon(Icons.lte_mobiledata),
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
                                child: const Text("Bloquer Christophe J-B"),
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
                                  child: const Text("Signaler Christophe J-B"),
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
