import 'package:chatbox/helpers.dart';
import 'package:chatbox/models/message_data.dart';
import 'package:chatbox/pages/profile_user.dart';
import 'package:chatbox/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:jiffy/jiffy.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [SliverList(delegate: SliverChildBuilderDelegate(_delegate))],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final date = Helpers.randomDate();
    return MessagesTitle(
        messagedata: MessageData(
            senderName: faker.person.name(),
            message: faker.lorem.sentence(),
            messageDate: date,
            dateMessage: Jiffy(date).fromNow(),
            profilePicture: Helpers.randomPictureUrl()));
  }
}

class MessagesTitle extends StatelessWidget {
  const MessagesTitle({super.key, required this.messagedata});

  final MessageData messagedata;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        // var route =
        //     MaterialPageRoute(builder: (context) => const ProfileUser());
        // Navigator.of(context).push(route);
      }),
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))),
        child: Padding(
          padding: const EdgeInsets.all(.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(
                  url: messagedata.profilePicture,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        messagedata.senderName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            letterSpacing: 0.2,
                            wordSpacing: 1.5,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
