import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FirebaseHelper {
  final auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseFirestore bd = FirebaseFirestore.instance;

  //Authentification d'un user
  Future<User?> handleSignIn(String mail, String mdp) async {
    final User? user =
        (await auth.signInWithEmailAndPassword(email: mail, password: mdp))
            .user;
    return user;
  }

  Future<bool> handleLogOut() async {
    await auth.signOut();
    return true;
  }

  //creation  d'un user
  Future<User> create(
      String mail, String mdp, String numero, String nom) async {
    final create =
        await auth.createUserWithEmailAndPassword(email: mail, password: mdp);
    final User? user = create.user;
    String uid = user!.uid;
    Map<String, String> map = {"numero": numero, "nom": nom, "uid": uid};
    addUser(uid, map);
    return user;
  }

  void gSignin() async {
    GoogleSignInAccount? googleSigninAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSigninAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    User? user = (await auth.signInWithCredential(credential)).user;

    // bd.collection("users").doc(user!.uid).set({
    //   "prenoms": user.displayName,
    //   "nom": user.displayName,
    //   "imageUrl": user.photoURL,
    //   "uid": user.uid,
    // });
    String uid = user!.uid;
    Map<String, String> map = {
      "uid": uid,
      "prenoms": user.displayName!,
      "nom": user.displayName!,
      "imageUrl": user.photoURL!
    };
    addUser(uid, map);
  }

  Future<bool> resetpassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await auth.signOut();
  }

  // database

  // le point d'entré de la bd
  static final entryPoint = FirebaseDatabase.instance.ref();
  // le point d'entré de l'entité user
  static final userEntry = entryPoint.child("users");
  // le point d'entré de l'entité  message
  static final entryMessage = entryPoint.child("messages");
  // le point d'entré de l'entité  conversation
  static final entryConversation = entryPoint.child("conversations");

  //ajouter un user
  addUser(String uid, Map map) {
    userEntry.child(uid).set(map);
  }

  // obtenir user
  Future<MyUser> getUser(String uid) async {
    DatabaseEvent snapshot = (await userEntry.child(uid).once());
    MyUser user = MyUser(snapshot.snapshot);
    return user;
  }

  File? imageFile;
  Future getimage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String filename = Uuid().v1();

    var ref =
        FirebaseStorage.instance.ref().child('images').child("$filename.jpg");

    var uploadtask = await ref.putFile(imageFile!);

    String imageurl = await uploadtask.ref.getDownloadURL();
    print(imageurl);
  }

  // envoyer sms dans la bd
  sendMessage(MyUser me, MyUser partenaire, String? texte, String? imageUrl) {
    //1=> ID1 + ID2
    String ref = getMessageRef(me.uid, partenaire.uid);
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    Map map = {
      "from": me.uid,
      "to": partenaire.uid,
      "text": texte,
      "dateString": date,
      "imageUrl": imageUrl
    };
    entryMessage.child(ref).child(date).set(map);

    //Notification de dernier message de conversation
    //on me notifie qu'une personne m'a ecrit
    entryConversation
        .child(me.uid)
        .child(partenaire.uid)
        .set(setConversation(partenaire, me.uid, texte!, date));
    //on notifie a une persone que je l'ai ecrit
    entryConversation
        .child(partenaire.uid)
        .child(me.uid)
        .set(setConversation(me, me.uid, texte, date));
  }

//fonction pour recuperer le dernier sms
  Map setConversation(
      MyUser user, String sender, String last, String dateString) {
    //user, lastmessage , date
    Map map = user.toMap();
    map["monId"] = sender;
    map["lastMessage"] = last;
    map["dateString"] = dateString;
    map["monId"] = sender;
    return map;
  }

  //fonction qui prend la reference de celui qui envoie le sms en premier et fais "+" a la ref de celui qui l'envoie en second
  getMessageRef(from, to) {
    List<String> list = [from, to];
    list.sort((a, b) => a.compareTo(b));
    String ref = "";
    for (var x in list) {
      ref += x + "+";
    }
    return ref;
  }

  //storage
  static final entryStorage = FirebaseStorage.instance.ref();
  static final entryUser = entryStorage.child('users');
  static final entrySmS = entryStorage.child('messages');
  //obtenir image
  static Future<String> savePic(File file, Reference reference) async {
    UploadTask task = reference.putFile(File(file.path));
    TaskSnapshot snap =
        await task.whenComplete(() => reference.getDownloadURL());
    Future<String> url = snap.ref.getDownloadURL();
    return url;
  }
}
