import 'package:chatbox/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagDataServices {
  // Stream<List<Message>> getMessage(String groupChatid)

  void sendMessage(String groupChatId, Message1 message) {
    var documentReference = FirebaseFirestore.instance
        .collection("message")
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, message.toHashMap());
    });
  }
}
