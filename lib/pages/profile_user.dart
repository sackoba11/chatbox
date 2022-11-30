import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/chat.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ProfileUser extends StatefulWidget {
  final MyUser partenaire;
  const ProfileUser({super.key, required this.partenaire});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  bool val = false;

  void change(bool index) {
    setState(() {
      val = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return (widget.partenaire == null)
        ? const Scaffold(
            body: Center(
              child: GFLoader(type: GFLoaderType.ios),
            ),
          )
        : Scaffold(
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
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 18.0),
                          child: InkWell(
                            child: CustomImage(
                              imageUrl: widget.partenaire.imageUrl,
                              initiales:
                                  widget.partenaire.initiales.toUpperCase(),
                              radius: MediaQuery.of(context).size.width / 6,
                            ),
                            onTap: () {
                              var route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Chatmessage(
                                          imageUrl:
                                              widget.partenaire.imageUrl));
                              Navigator.of(context).push(route);
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: h / 120,
                    ),
                    SizedBox(
                        height: 40,
                        width: w - 20,
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${widget.partenaire.nomf}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ))),
                    SizedBox(
                      height: h / 120,
                    ),
                    SizedBox(
                        height: 40,
                        width: w - 20,
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${widget.partenaire.prenom}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ))),
                    SizedBox(
                      height: h / 120,
                    ),
                    SizedBox(
                      width: w - 20,
                      child: Card(
                        child: Row(
                          children: [
                            SizedBox(
                                height: 40,
                                width: w / 1.3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "${widget.partenaire.numero}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                )),
                            const Icon(Icons.phone)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h / 120,
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
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Notifications en mode silence",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                    onTap: () {},
                                    child: Text(
                                        "Bloquer ${widget.partenaire.nom}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
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
                                      onTap: () {},
                                      child: Text(
                                          "Signler ${widget.partenaire.nom}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
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
