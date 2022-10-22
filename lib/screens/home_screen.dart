import 'package:chatbox/helpers.dart';
import 'package:chatbox/pages/calls_page.dart';
import 'package:chatbox/pages/contacts_page.dart';
import 'package:chatbox/pages/messages_page.dart';
import 'package:chatbox/pages/notification_page.dart';

import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/avatar.dart';
import 'package:chatbox/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final ValueNotifier<int> pageIndex  = ValueNotifier(0);
  final ValueNotifier<String> title  = ValueNotifier('message');

  final pages = const [
    MessagesPage(),
    NotificationPage(),
    CallsPage(),
    ContactsPage(),
  ];

  final pageTitles = [
    'Messages',
    'Notifications',
    'Calls',
    'Contacts'
  ];

  void _onNavigationItemSelected(index){
      title.value = pageTitles[index];
      pageIndex.value = index;
    }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:ValueListenableBuilder(
          valueListenable: title,
          builder:((context,String value, _) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            );
          }),
        ),
        leadingWidth:54 ,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: Icons.search,
            onTap: () {
              
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(url:Helpers.randomPictureUrl(),),
          )
        ] ,
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder:((context,int value, _) {
          return pages[value];
        })
          ,
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }

  
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key? key, required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<int>onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  
  var selectedIndex = 0;

  void handleItemSelected(int index){
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: true,
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationBarItem(
               index: 0,
              lable:'Message' ,
              icon: CupertinoIcons.bubble_left_bubble_right_fill,
              onTap: handleItemSelected,
               isSelected: (selectedIndex == 0),
              ),
              _NavigationBarItem(
                index: 1,
              lable:'Notification' ,
              icon: CupertinoIcons.bell_solid,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
              ),
              _NavigationBarItem(
                 index: 2,
              lable:'Calls' ,
              icon: CupertinoIcons.phone_fill,
              onTap:handleItemSelected,
              isSelected: (selectedIndex == 2),
              ),
              _NavigationBarItem(
                 index: 3,
              lable:'Contacts' ,
              icon: CupertinoIcons.person_2_fill,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 3),
              ),
          ],
        ),
      );
  }
}

class _NavigationBarItem extends StatelessWidget {
 const  _NavigationBarItem({super.key, required this.lable, required this.icon, required this.index, required this.onTap, required this.isSelected});



  final ValueChanged<int> onTap;
  final int index;
  final String lable;
  final  IconData icon;
  final bool isSelected ;
   
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:() {
        onTap(index);
      }, 
      child: SizedBox(
        height: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ?AppColors.secondary:null,
              ),
              SizedBox(height: 8,),
            Text(
              lable,
              style:isSelected 
              ?const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary
                ) 
              :const TextStyle(fontSize: 11)
              )
          ],
        ),
      ),
    );
  }
}


