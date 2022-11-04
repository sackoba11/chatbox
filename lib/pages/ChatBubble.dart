import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/date_helper.dart';
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

    return <Widget>[
      // (moi)
      //     ? Padding(padding: EdgeInsets.all(5.0))
      //     : CustomImage(
      //         //color: Color(0XFFEA5863),
      //         imageUrl: widget.partenaire.imageUrl,
      //         initiales: widget.partenaire.initiales,
      //         radius: 15,
      //       ),
      Expanded(
          child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Container(
            decoration: decoration,
            padding:
                EdgeInsets.all((widget.message.imageUrl.isNotEmpty) ? 5 : 10),
            child:
                /*   (widget.message.imageUrl.isNotEmpty)
                ? CustomImage(
                    imageUrl: widget.message.imageUrl,
                    initiales: null,
                    radius: null,
                  )
                :  */
                (widget.message.text.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text(
                          widget.message.text,
                        ),
                      )
                    : Container(),
          ),
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
