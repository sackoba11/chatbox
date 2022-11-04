import 'dart:io';
import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilController extends StatefulWidget {
  const ProfilController({Key? key}) : super(key: key);

  @override
  _ProfilControllerState createState() => _ProfilControllerState();
}

class _ProfilControllerState extends State<ProfilController> {
  MyUser? me;
  final TextEditingController _prenoms = TextEditingController();
  final TextEditingController _noms = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final User? user = FirebaseHelper().auth.currentUser;
  @override
  void initState() {
    super.initState();
    _getUser();
  }
  /*  @override
  void dispose() {
    _getUser();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return
        // (me == null)
        //     ? Scaffold(
        //         body: Center(
        //           child: Text("Chargement..."),
        //         ),
        //       )
        Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //image(),
              CustomImage(
                imageUrl: me!.imageUrl,
                initiales: me!.initiales.toUpperCase(),
                radius: MediaQuery.of(context).size.width / 6,
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
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _prenoms,
                decoration: InputDecoration(hintText: me!.prenoms),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _noms,
                decoration: InputDecoration(hintText: me!.nom),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(hintText: user!.email),
              ),
              const SizedBox(
                height: 250,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary),
                onPressed: upDateUser,
                child: const Text("Sauvegarder"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: logOut,
                  child: const Text(
                    "Se Déconnecter",
                    style: TextStyle(color: AppColors.secondary),
                  )),
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
            .handleLogOut()
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

  upDateUser() {
    Map map = me!.toMap();
    if (_prenoms.text != "" && _prenoms.text != null) {
      map["prenoms"] = _prenoms.text;
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
//   image() {
//     var images;
//     /*  FirebaseHelper().getUser(user!.uid).then((me) {
//       setState(() {
//         this.me = me; */

//     if (me!.imageUrl != null) {
//       return Container(
//         child: CircleAvatar(
//           radius: 25,
//           child: Image(image: NetworkImage(me!.imageUrl!)),
//         ),
//         //Avatar.medium(url: me.imageUrl),
//       );
//     } else {
//       return CircleAvatar(
//         radius: 25,
//         child: Text(
//           me!.initiales,
//           //style: const TextStyle(color: Colors.black),
//         ),
//       );
//     }
//   }
 









/* import 'dart:io';

import 'package:chatbox/firebase.dart';
import 'package:chatbox/helpers.dart';
import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/avatar.dart';
import 'package:chatbox/widgets/glowinf_action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final auth = FirebaseAuth.instance;

  final User? user = FirebaseAuth.instance.currentUser;
  MyUser? me;
  final auth = FirebaseAuth.instance;

  //late MyUser me;
  TextEditingController _prenom = TextEditingController();
  TextEditingController _nom = TextEditingController();
  TextEditingController _uid = TextEditingController();
  @override
  initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // title: ValueListenableBuilder(
          //     valueListenable: title,
          //     builder: (BuildContext context, String value, _) {
          //       return Text(
          //         value,
          //         style:
          //             const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //       );
          //     }),
          title: const Text(
            "Profil",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          actions: [
            GlowingActionButton(
                color: AppColors.iconDark,
                icon: Icons.logout,
                onPressed: () => () {
                      auth.signOut();
                    })
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      GlowingActionButton(
                          color: AppColors.iconDark,
                          icon: Icons.edit,
                          size: 40,
                          onPressed: () {}),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 48.0),
                      child: CircleAvatar(
                        radius: 45,
                        child: Text(
                          me!.initiales,
                          style: TextStyle(fontSize: 50),
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      GlowingActionButton(
                          color: AppColors.iconDark, //Colors.grey.shade700,
                          icon: Icons.camera_alt,
                          size: 40,
                          onPressed: () {}),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _uid,
                decoration: InputDecoration(hintText: me!.uid),
              ),
              TextField(
                controller: _nom,
                decoration: InputDecoration(hintText: me!.nom),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _prenom,
                decoration: InputDecoration(hintText: me!.prenoms),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 65),
                  width: MediaQuery.of(context).size.width - 100,
                  child: const Text(
                      'Ce profil est un profil de teste de logiciel prototype')),
              const Divider(
                height: 40,
                indent: 65,
                thickness: 1,
              ),
              const Divider(
                height: 40,
                indent: 65,
                thickness: 1,
              ),
            ]),
          ),
        ));
  }

  //  image() {
  //   var images;
  //   FirebaseHelper().getUser(user!.uid).then((me) {
  //     setState(() {
  //       this.me = me;

  //       if (me.imageUrl != null) {
  //         return Avatar.medium(url: me.imageUrl);
  //       } else {
  //         return CircleAvatar(
  //           radius: 25,
  //           child: Text(
  //             me.initiales,
  //             style: TextStyle(color: Colors.black),
  //           ),
  //         );
  //       }
  //     });
  //   });

  //}

  Future<void> _takePic(ImageSource source) async {
    final XFile? img = await ImagePicker()
        .pickImage(source: source, maxHeight: 500, maxWidth: 500);
    if (img != null) {
      File file = File(img.path);
      FirebaseHelper.savePic(file, FirebaseHelper.entryUser.child(me!.uid))
          .then((str) {
        Map map = me!.toMap();
        map["imageurl"] = str;
        FirebaseHelper().addUser(me!.uid, map);
        _getUser();
      });
    }
  }

  updateUser() {
    Map map = me!.toMap();
    if (_prenom.text != "" && _prenom.text != null) {
      map["prenom"] = _prenom.text;
    }
    if (_nom.text != "" && _nom.text != null) {
      map["nom"] = _nom.text;
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
}
 */