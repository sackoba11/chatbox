import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Message {
  late String from;
  late String to;
  late String text;
  late String dateString;
  late String imageUrl;

  Message(DataSnapshot snapshot) {
    from = snapshot.child("from").value.toString();
    to = snapshot.child("to").value.toString();
    text = snapshot.child("text").value.toString();
    dateString = snapshot.child("dateString").value.toString();
    imageUrl = snapshot.child("imageUrl").value.toString();
  }
}

class Message1 {
  final String idForm;
  final String idTo;
  final String timesTamp;
  final String contnent;
  final int type;

  Message1(this.idForm, this.idTo, this.timesTamp, this.contnent, this.type);

  Map<String, dynamic> toHashMap() {
    return {
      'idForm': idForm,
      'idTo': idTo,
      'timesTamp': timesTamp,
      'tpe': type
    };
  }
}
