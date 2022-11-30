import 'package:firebase_database/firebase_database.dart';

class MyUser {
  late String uid;
  late String nom;
  late String? nomf;
  late String? prenom;
  late String? numero;
  late String? imageUrl;
  late String initiales;

  MyUser(DataSnapshot snapshot) {
    uid = snapshot.key!;
    Map map = snapshot.value as Map;
    // prenoms = map["prenoms"];
    nom = map["nom"];
    imageUrl = map["imageUrl"];
    numero = map["numero"];
    // if (prenoms != "" && prenoms.length > 0) {
    //   initiales = prenoms[0];
    // }
    nomf = nom[0];
    for (int i = 1; i < nom.length; i++) {
      if (nom[i] != " ") {
        nomf = nomf! + nom[i];
      } else {
        break;
      }
    }
    prenom = "";
    for (int i = nomf!.length + 1; i < nom.length; i++) {
      prenom = prenom! + nom[i];
    }

    if (nom != "" && nom.length > 0) {
      initiales = nom[0];
      for (int i = 1; i < nom.length; i++) {
        if (nom[i] == " ") {
          initiales = initiales + nom[i + 1];
          break;
        }
      }
    }
  }
  Map toMap() {
    return {
      // "prenoms": prenoms,
      "numero": numero,
      "nom": nom,
      "imageUrl": imageUrl,
      "uid": uid
    };
  }
}
