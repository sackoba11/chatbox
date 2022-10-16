import 'package:chatbox/helpers.dart';
import 'package:chatbox/pages/calls_page.dart';
import 'package:chatbox/pages/contact_page.dart';
import 'package:chatbox/pages/message_page.dart';
import 'package:chatbox/pages/notification_page.dart';
import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/glowinf_action_button.dart';
import 'package:chatbox/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier("Messages");

  final pages = const [
    MessagesPage(),
    NotificationPage(),
    CallsPAge(),
    ContactPage()
  ];

  final pageTitles = ["Messages", "Notifications", "calls", "Contacts"];

  void onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
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
          child: IconBackground(
              icon: Icons.search,
              onTap: () {
                print("search");
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(
              url: Helpers.randomPictureUrl(),
            ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GlowingActionButton(
                      color: AppColors.secondary,
                      icon: CupertinoIcons.add,
                      onPressed: (() {
                        print("To do on new message");
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
      {super.key,
      this.isSelected = false,
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
