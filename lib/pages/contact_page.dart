import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/conversation_model.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/date_helper.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/screens/chat_screen.dart';
import 'package:chatbox/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ContactController extends StatefulWidget {
  const ContactController({Key? key}) : super(key: key);

  @override
  State<ContactController> createState() => _MessageControllerState();
}

class _MessageControllerState extends State<ContactController> {
  String uid = FirebaseHelper().auth.currentUser!.uid;

  final User? user = FirebaseAuth.instance.currentUser;
  late MyUser me;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: FirebaseHelper.entryConversation.child(uid),
        sort: (a, b) => b.key!.compareTo(a.key!),
        reverse: false,
        itemBuilder: (BuildContext ctx, DataSnapshot snap,
            Animation<double> animation, int index) {
          Conversation conversation = Conversation(snap);
          //String sub = (conversation.uid == uid) ? "Moi : " : "";
          //sub += (conversation.msg);
          return Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              children: [
                ListTile(
                  leading: CustomImage(
                    imageUrl: conversation.user.imageUrl,
                    initiales: conversation.user.initiales,
                    radius: 20,
                  ),
                  title: Text(
                      "${conversation.user.nomf} ${conversation.user.prenom}"),
                  //subtitle: Text(""),
                  // trailing: Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 8.0),
                  //       child: Text(DateHelper().convert(conversation.date)),
                  //     ),
                  //   ],
                  // ),
                  onTap: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext ctx) {
                      return ChatSceen(partenaire: conversation.user);
                    }));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          );
        });
  }

  _getUser() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
  }
}

















// import 'package:chatbox/firebase.dart';
// import 'package:chatbox/models/customimage.dart';
// import 'package:chatbox/models/user_model.dart';
// import 'package:chatbox/screens/chat_screen.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';

// class ContactController extends StatefulWidget {
//   const ContactController({Key? key}) : super(key: key);

//   @override
//   ContactControllerState createState() => ContactControllerState();
// }

// class ContactControllerState extends State<ContactController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FirebaseAnimatedList(
//           query: FirebaseHelper.userEntry,
//           sort: (a, b) => (a
//               .child('prenom')
//               .value
//               .toString()
//               .toLowerCase()
//               .compareTo(b.child('prenom').value.toString().toLowerCase())),
//           itemBuilder: (BuildContext ctx, DataSnapshot snap,
//               Animation<double> animation, int index) {
//             MyUser newUser = MyUser(snap);

//             return Flex(
//               direction: Axis.vertical,
//               children: [
//                 Column(children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return ChatSceen(partenaire: newUser);
//                       }));
//                     },
//                     child: ListTile(
//                       leading: CustomImage(
//                           imageUrl: newUser.imageUrl,
//                           initiales: newUser.initiales,
//                           radius: 22),
//                       title: Text("${newUser.nomf} ${newUser.prenom}"),
//                       subtitle: const Text("Ecrivez Moi ..."),
//                       trailing: IconButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               return ChatSceen(partenaire: newUser);
//                             }),
//                           );
//                         },
//                         icon: const Icon(Icons.message),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width,
//                           height: 1,
//                           color: Colors.grey,
//                         ),
//                       )
//                     ],
//                   )
//                 ])
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
