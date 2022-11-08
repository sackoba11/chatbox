import 'package:chatbox/firebase.dart';
import 'package:chatbox/models/customimage.dart';
import 'package:chatbox/models/user_model.dart';
import 'package:chatbox/pages/calls_page.dart';
import 'package:chatbox/pages/contact_page.dart';
import 'package:chatbox/pages/message_page.dart';
import 'package:chatbox/pages/notification_page.dart';
import 'package:chatbox/pages/profil_page.dart';
import 'package:chatbox/screens/select_contact.dart';
import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/glowinf_action_button.dart';
import 'package:chatbox/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreens();
  }
}

class HomeScreens extends StatefulWidget {
  const HomeScreens({
    super.key,
  });

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier("Messages");

  final pages = const [
    MessageController(),
    NotificationPage(),
    CallsPAge(),
    ContactController()
  ];

  final pageTitles = ["Messages", "Notifications", "calls", "Contacts"];

  void onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  final User? user = FirebaseAuth.instance.currentUser;
  late MyUser me;

  @override
  void initState() {
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
        title: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, _) {
              return Text(
                value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              );
            }),
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(icon: Icons.search, onTap: () {}),
        ),
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: CustomImage(
                imageUrl: me.imageUrl,
                initiales: me.initiales.toUpperCase(),
                radius: MediaQuery.of(context).size.width / 17,
              ),
            ),
            onTap: () {
              var route = MaterialPageRoute(
                  builder: (BuildContext context) => const ProfilController());
              Navigator.of(context).push(route);
            },
          )
        ],
        toolbarTextStyle: Theme.of(context).textTheme.bodyText2,
        titleTextStyle: Theme.of(context).textTheme.headline6,
      ),
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: onNavigationItemSelected,
      ),
    );
  }

  _getUser() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
          top: false,
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                    index: 0,
                    label: "Messages",
                    isSelected: (selectedIndex == 0),
                    icon: CupertinoIcons.bubble_left_bubble_right_fill,
                    ontap: handleItemSelected),
                _NavigationBarItem(
                    index: 1,
                    label: "Notifications",
                    isSelected: (selectedIndex == 1),
                    icon: CupertinoIcons.bell_solid,
                    ontap: handleItemSelected),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: GlowingActionButton(
                      color: AppColors.secondary,
                      icon: CupertinoIcons.add,
                      onPressed: (() {
                        var route = MaterialPageRoute(
                            builder: (context) => const SelectContact());

                        Navigator.of(context).push(route);
                      })),
                ),
                _NavigationBarItem(
                    index: 2,
                    label: "Calls",
                    isSelected: (selectedIndex == 2),
                    icon: CupertinoIcons.phone_fill,
                    ontap: handleItemSelected),
                _NavigationBarItem(
                    index: 3,
                    label: "Contacts",
                    isSelected: (selectedIndex == 3),
                    icon: CupertinoIcons.person_2_fill,
                    ontap: handleItemSelected),
              ],
            ),
          )),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {this.isSelected = false,
      required this.ontap,
      required this.index,
      required this.label,
      required this.icon});

  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (() {
        ontap(index);
      }),
      child: SizedBox(
        width: 70,
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? AppColors.secondary : null),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(fontSize: 11),
            )
          ],
        ),
      ),
    );
  }
}
