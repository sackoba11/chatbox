import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/screens/chat_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Addusers extends StatefulWidget {
  const Addusers({Key? key}) : super(key: key);

  @override
  ContactControllerState createState() => ContactControllerState();
}

class ContactControllerState extends State<Addusers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: FirebaseHelper.userEntry,
          sort: (a, b) => (a
              .child('prenom')
              .value
              .toString()
              .toLowerCase()
              .compareTo(b.child('prenom').value.toString().toLowerCase())),
          itemBuilder: (BuildContext ctx, DataSnapshot snap,
              Animation<double> animation, int index) {
            MyUser newUser = MyUser(snap);

            return Flex(
              direction: Axis.vertical,
              children: [
                Column(children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatSceen(partenaire: newUser);
                      }));
                    },
                    child: ListTile(
                      leading: CustomImage(
                          imageUrl: newUser.imageUrl,
                          initiales: newUser.initiales,
                          radius: 22),
                      title: Text("${newUser.nomf} ${newUser.prenom}"),
                      subtitle: const Text("Ecrivez moi ..."),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ChatSceen(partenaire: newUser);
                            }),
                          );
                        },
                        icon: const Icon(Icons.message),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  )
                ])
              ],
            );
          },
        ),
      ),
    );
  }
}
