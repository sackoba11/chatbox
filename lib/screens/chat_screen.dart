import 'dart:io';
import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/ChatBubble.dart';
import 'package:chatbox/pages/profile_user.dart';
import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/glowinf_action_button.dart';
import 'package:chatbox/widgets/widgets.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/message.dart';

class ChatSceen extends StatefulWidget {
  static Route route(MyUser partenaire) => MaterialPageRoute(
      builder: (context) => ChatSceen(
            partenaire: partenaire,
          ));
  final MyUser partenaire;
  const ChatSceen({
    super.key,
    required this.partenaire,
  });

  @override
  State<ChatSceen> createState() => _ChatSceenState();
}

class _ChatSceenState extends State<ChatSceen> {
  MyUser? me;
  @override
  void initState() {
    super.initState();
    String uid = FirebaseHelper().auth.currentUser!.uid;
    FirebaseHelper().getUser(uid).then((user) {
      setState(() {
        me = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (me == null)
        ? const Scaffold(
            body: Center(
              child: GFLoader(type: GFLoaderType.ios),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 54,
              leading: Align(
                alignment: Alignment.centerRight,
                child: IconBackground(
                    onTap: (() {
                      Navigator.of(context).pop();
                    }),
                    icon: CupertinoIcons.back),
              ),
              title: InkWell(
                child: _AppBarTitle(
                  partenaire: widget.partenaire,
                ),
                onTap: () {
                  var route = MaterialPageRoute(
                      builder: (BuildContext context) => ProfileUser(
                            partenaire: widget.partenaire,
                          ));
                  Navigator.of(context).push(route);
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: IconBorder(
                      icon: CupertinoIcons.video_camera_solid,
                      onTap: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Center(
                    child: IconBorder(
                      icon: CupertinoIcons.phone_solid,
                      onTap: () {},
                    ),
                  ),
                ),
              ],
              toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
              titleTextStyle: Theme.of(context).textTheme.headline6,
            ),
            body: InkWell(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: [
                  Flexible(
                      child: (me != null)
                          ? FirebaseAnimatedList(
                              query: FirebaseHelper.entryMessage.child(
                                  FirebaseHelper().getMessageRef(
                                      me!.uid, widget.partenaire.uid)),
                              sort: (a, b) => b.key!.compareTo(a.key!),
                              reverse: true,
                              itemBuilder: (BuildContext ctx, DataSnapshot snap,
                                  Animation<double> animation, int index) {
                                Message msg = Message(snap);
                                return ChatBubble(
                                    partenaire: widget.partenaire,
                                    message: msg,
                                    animation: animation);
                                // ListTile(title: Text(msg.text!));
                              })
                          : const Center(
                              child: GFLoader(type: GFLoaderType.ios),
                            )),
                  _ActionBar(
                    partenaire: widget.partenaire,
                    me: me,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
  }
}

// class _DataLabel extends StatelessWidget {
//   const _DataLabel({required this.label});

//   final String label;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 32),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//             child: Text(
//               label,
//               style: const TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textFaded),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _AppBarTitle extends StatefulWidget {
  const _AppBarTitle({required this.partenaire});

  final MyUser partenaire;

  @override
  State<_AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<_AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImage(
          imageUrl: widget.partenaire.imageUrl,
          initiales: widget.partenaire.initiales,
          radius: 15,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.partenaire.nom} ${widget.partenaire.prenom}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 2,
            ),
            const Text(
              "En ligne..",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )
          ],
        ))
      ],
    );
  }
}

class _ActionBar extends StatefulWidget {
  final partenaire;
  final me;
  const _ActionBar({required this.partenaire, required this.me});

  @override
  State<_ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<_ActionBar> {
  final TextEditingController _controllerSms = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(0.0),
                onPressed: () => _takeAPic(ImageSource.camera),
                icon: const Icon(
                  CupertinoIcons.camera_fill,
                  size: 25,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ))),
                child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () => _takeAPic(ImageSource.gallery),
                    icon: const Icon(
                      CupertinoIcons.photo_fill,
                      size: 25,
                    )),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: TextField(
                  controller: _controllerSms,
                  style: const TextStyle(fontSize: 14),
                  maxLines: null,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Saisissez votre message...',
                    border: InputBorder.none,
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 24,
                ),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: Icons.send_sharp,
                  size: 45,
                  onPressed: () {
                    _sendButtonPressed();
                    setState(() {
                      ChatSceen(
                        partenaire: widget.partenaire,
                      );
                    });
                  },
                ),
              )
            ],
          ),
          //emojiSelect(),
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
      config: const Config(
        columns: 7,
      ),
      onEmojiSelected: ((category, emoji) {
        print("emoji");
      }),
    );
  }

  _sendButtonPressed() {
    if (_controllerSms.text.isNotEmpty && _controllerSms.text != "") {
      String text = _controllerSms.text;
      // 1=> envoyer le texte sur firebase
      FirebaseHelper().sendMessage(widget.me, widget.partenaire, text, null);
      //2=> effacer le contenu du champ de saisie
      _controllerSms.clear();
      //3=> fermer ce champ de texte
      FocusScope.of(context).requestFocus(FocusNode());
      //4=>afficher le toast
    } else {
      // aucune saisie effectuée
    }
  }

  Future<void> _takeAPic(ImageSource source) async {
    final XFile? picked = await ImagePicker()
        .pickImage(source: source, maxHeight: 1000, maxWidth: 1000);
    if (picked != null) {
      File file = File(picked.path);
      String date = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseHelper.entrySmS.child(widget.me.uid).child(date);
      FirebaseHelper.savePic(file, ref).then((imageUrl) {
        FirebaseHelper()
            .sendMessage(widget.me, widget.partenaire, null, imageUrl);
      });
    }
  }
}
