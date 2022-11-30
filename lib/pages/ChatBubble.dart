import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/date_helper.dart';
import 'package:chatbox/pages/chat.dart';
import 'package:flutter/material.dart';
import 'package:chatbox/models/message.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/theme.dart';

class ChatBubble extends StatefulWidget {
  final MyUser partenaire;
  final Message message;
  final Animation<double> animation;

  const ChatBubble(
      {Key? key,
      required this.partenaire,
      required this.message,
      required this.animation})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final String myUid = FirebaseHelper().auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    //SizeTransition pour que chatbubble prenne la taille du sms
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: widget.animation, curve: Curves.easeIn),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: bubble(myUid == widget.message.from),
          ),
        ));
  }

  //bubble pour que la bulle se place en fonction de celui qui envoie le sms
  List<Widget> bubble(bool moi) {
    const borderRadius = 26.0;

    BoxDecoration decoration1 = const BoxDecoration(
      color: AppColors.secondary,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius)),
    );
    BoxDecoration decoration2 = const BoxDecoration(
        color: Color.fromRGBO(144, 202, 249, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ));
    CrossAxisAlignment alignment =
        (moi) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    BoxDecoration? decoration = (moi) ? decoration1 : decoration2;

    Widget test(String? imageUrl, String? text) {
      if (imageUrl != null && imageUrl.contains("http")) {
        ImageProvider provider = CachedNetworkImageProvider(imageUrl);
        return InkWell(
          child: Image(
            image: provider,
            width: 150,
            height: 150,
          ),
          onTap: () {
            var route = MaterialPageRoute(
                builder: (BuildContext context) =>
                    Chatmessage(imageUrl: imageUrl));
            Navigator.of(context).push(route);
          },
        );
      } else if (text != null) {
        return Container(
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 17),
            ),
          ),
        );
      } else {
        Container();
      }
      return Container();
    }

    return <Widget>[
      (moi)
          ? const Padding(padding: EdgeInsets.all(5.0))
          : CustomImage(
              imageUrl: widget.partenaire.imageUrl,
              initiales: widget.partenaire.initiales,
              radius: 15,
            ),
      Expanded(
          child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          test(widget.message.imageUrl, widget.message.text),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DateHelper().convert(widget.message.dateString),
                style: const TextStyle(
                    color: AppColors.textFaded,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      )),
    ];
  }
}
