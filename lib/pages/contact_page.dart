import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/screens/chat_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:jiffy/jiffy.dart';

class ContactController extends StatefulWidget {
  const ContactController({Key? key}) : super(key: key);

  @override
  _ContactControllerState createState() => _ContactControllerState();
}

class _ContactControllerState extends State<ContactController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: FirebaseHelper.userEntry,
          sort: (a, b) => (a
              .child('prenoms')
              .value
              .toString()
              .toLowerCase()
              .compareTo(b.child('prenoms').value.toString().toLowerCase())),
          itemBuilder: (BuildContext ctx, DataSnapshot snap,
              Animation<double> animation, int index) {
            MyUser newUser = MyUser(snap);
            if (FirebaseHelper().auth.currentUser!.uid == null) {
              return const Center(child: Text("Aucun utilisateur"));
            } else {
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
                        title: Text("${newUser.nom} ${newUser.prenoms}"),
                        subtitle: const Text("Ecrivez Moi ..."),
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
            }
          },
        ),
      ),
    );
  }
}












// import 'package:chatbox/helpers.dart';
// import 'package:chatbox/models/message_data.dart';
// import 'package:chatbox/pages/profile_user.dart';
// import 'package:chatbox/widgets/avatar.dart';
// import 'package:flutter/material.dart';
// import 'package:faker/faker.dart';
// import 'package:jiffy/jiffy.dart';

// class ContactPage extends StatelessWidget {
//   const ContactPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [SliverList(delegate: SliverChildBuilderDelegate(_delegate))],
//     );
//   }

//   Widget _delegate(BuildContext context, int index) {
//     final date = Helpers.randomDate();
//     return MessagesTitle(
//         messagedata: MessageData(
//             senderName: faker.person.name(),
//             message: faker.lorem.sentence(),
//             messageDate: date,
//             dateMessage: Jiffy(date).fromNow(),
//             profilePicture: Helpers.randomPictureUrl()));
//   }
// }

// class MessagesTitle extends StatelessWidget {
//   const MessagesTitle({super.key, required this.messagedata});

//   final MessageData messagedata;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (() {
//         // var route =
//         //     MaterialPageRoute(builder: (context) => const ProfileUser());
//         // Navigator.of(context).push(route);
//       }),
//       child: Container(
//         height: 100,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: const BoxDecoration(
//             border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
//         child: Padding(
//           padding: const EdgeInsets.all(.0),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Avatar.medium(
//                   url: messagedata.profilePicture,
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         messagedata.senderName,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             letterSpacing: 0.2,
//                             wordSpacing: 1.5,
//                             fontWeight: FontWeight.w900),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
