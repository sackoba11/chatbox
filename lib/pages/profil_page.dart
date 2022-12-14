// ignore_for_file: unrelated_type_equality_checks

import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/glowinf_action_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // title: ValueListenableBuilder(
          //     valueListenable: title,
          //     builder: (BuildContext context, String value, _) {
          //       return Text(
          //         value,
          //         style:
          //             const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //       );
          //     }),
          title: const Text(
            "Profil",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
          titleTextStyle: Theme.of(context).textTheme.headline6,
        ),
        body: ListView(children: [
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  GlowingActionButton(
                      color: AppColors.iconDark,
                      icon: Icons.edit,
                      size: 40,
                      onPressed: (() {})),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 48.0),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage("images/1.jpg"),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  GlowingActionButton(
                      color: AppColors.iconDark, //Colors.grey.shade700,
                      icon: Icons.camera_alt,
                      size: 40,
                      onPressed: (() {})),
                ],
              ),
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
                      Icons.person,
                      size: 35,
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
                            Text("Nom"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Sackaba")
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.only(left: 65),
                  width: MediaQuery.of(context).size.width - 100,
                  child: const Text(
                      'fvdbndfbvfbhbnrjbnergerngjngrjnrejgernjgrbgergerger guhrv'))
            ],
          ),
          const Divider(
            height: 40,
            indent: 65,
            thickness: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(Icons.add_circle_outline_outlined),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Actu"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("L'effort fait les forts")
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 40,
            indent: 65,
            thickness: 1,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(Icons.phone),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("T??l??phone"),
                              SizedBox(
                                height: 5,
                              ),
                              Text("+225 0555324247")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ])
        ]));
  }
}
