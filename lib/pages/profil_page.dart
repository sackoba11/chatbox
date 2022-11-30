import 'dart:io';
import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/chat.dart';
import 'package:chatbox/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';

class ProfilController extends StatefulWidget {
  const ProfilController({Key? key}) : super(key: key);

  @override
  State<ProfilController> createState() => _ProfilControllerState();
}

class _ProfilControllerState extends State<ProfilController> {
  final TextEditingController _noms = TextEditingController();
  final TextEditingController _numero = TextEditingController();

  final User? user = FirebaseHelper().auth.currentUser;
  MyUser? me;

  @override
  void initState() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return (me == null)
        ? const Scaffold(
            body: Center(
              child: GFLoader(type: GFLoaderType.ios),
            ),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: CustomImage(
                        imageUrl: me!.imageUrl,
                        initiales: me!.initiales.toUpperCase(),
                        radius: MediaQuery.of(context).size.width / 6,
                      ),
                      onTap: () {
                        var route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Chatmessage(imageUrl: me!.imageUrl));
                        Navigator.of(context).push(route);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            _takeAPic(ImageSource.camera);
                          },
                          icon: const Icon(Icons.camera_enhance),
                        ),
                        IconButton(
                          onPressed: () {
                            _takeAPic(ImageSource.gallery);
                          },
                          icon: const Icon(Icons.photo_library),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h / 120,
                    ),
                    SizedBox(
                        height: 40,
                        width: w - 20,
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${me!.nomf}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ))),
                    SizedBox(
                      height: h / 120,
                    ),
                    SizedBox(
                        height: 40,
                        width: w - 20,
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${me!.prenom}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ))),
                    SizedBox(
                      height: h / 120,
                    ),
                    Card(
                      child: Row(
                        children: [
                          SizedBox(
                              height: 40,
                              width: w / 1.3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "${me!.numero}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              )),
                          const Icon(Icons.phone)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h / 120,
                    ),
                    Card(
                      child: Row(
                        children: [
                          SizedBox(
                              height: 40,
                              width: w / 1.3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                ),
                                child: Text(
                                  "${user!.email}",
                                  style: const TextStyle(fontSize: 20),
                                ),
                              )),
                          const Icon(Icons.email)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: h / 7,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary),
                      onPressed: () {
                        modification();
                      },
                      child: const Text("Modifier"),
                    ),
                    SizedBox(
                      height: h / 120,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary),
                      onPressed: logOut,
                      child: const Text("Se Déconnecter"),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> logOut() async {
    Text title = const Text("Se Déconnecter");
    Text content = const Text("Etes vous sur de vouloir vous déconnecter ?");
    ElevatedButton noBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Non"),
    );
    ElevatedButton yesBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
      ),
      onPressed: () {
        FirebaseHelper()
            .signOutFromGoogle()
            .then((bool) => {Navigator.of(context).pop()});
      },
      child: const Text("Oui"),
    );
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  content: content,
                  actions: <Widget>[yesBtn, noBtn],
                )
              : AlertDialog(
                  title: title,
                  content: content,
                  actions: <Widget>[yesBtn, noBtn],
                );
        });
  }

  Future<void> modification() async {
    Text title = const Text("Modification");
    ;
    Container content = Container(
        height: MediaQuery.of(context).size.height / 5,
        child: Column(
          children: [
            TextField(
              controller: _noms,
              decoration: InputDecoration(hintText: me!.nom),
            ),
            TextField(
              controller: _numero,
              decoration: InputDecoration(hintText: me!.numero),
            ),
          ],
        ));

    ElevatedButton noBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Annulé"),
    );
    ElevatedButton yesBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
      ),
      onPressed: () {
        upDateUser();
        Navigator.of(context).pop();
      },
      child: const Text("modifier"),
    );
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return (Theme.of(context).platform == TargetPlatform.iOS)
              ? CupertinoAlertDialog(
                  title: title,
                  content: content,
                  actions: <Widget>[yesBtn, noBtn],
                )
              : AlertDialog(
                  title: title,
                  content: content,
                  actions: <Widget>[yesBtn, noBtn],
                );
        });
  }

  upDateUser() {
    Map map = me!.toMap();
    if (_numero.text != "" && _numero.text != null) {
      map["numero"] = _numero.text;
    }
    if (_noms.text != "" && _noms.text != null) {
      map["nom"] = _noms.text;
    }

    FirebaseHelper().addUser(me!.uid, map);
    _getUser();
  }

  _getUser() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
  }

  Future<void> _takeAPic(ImageSource source) async {
    final XFile? img = await ImagePicker()
        .pickImage(source: source, maxHeight: 500, maxWidth: 500);
    if (img != null) {
      File file = File(img.path);
      FirebaseHelper.savePic(file, FirebaseHelper.entryUser.child(me!.uid))
          .then((str) {
        Map map = me!.toMap();
        map["imageUrl"] = str;
        FirebaseHelper().addUser(me!.uid, map);
        _getUser();
      });
    }
  }
}
