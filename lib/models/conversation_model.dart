import 'package:chatbox/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class Conversation {
  late MyUser user;
  late String date;
  late String msg;
  late String uid;

  Conversation(DataSnapshot snapshot) {
    user = MyUser(snapshot);
    uid = snapshot.child("monId").value.toString();
    msg = snapshot.child("lastMessage").value.toString();
    date = snapshot.child("dateString").value.toString();
  }
}
