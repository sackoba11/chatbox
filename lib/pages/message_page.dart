import 'package:chatbox/helpers.dart';
import 'package:chatbox/models/message_data.dart';
import 'package:chatbox/models/story_data.dart';
import 'package:chatbox/screens/chat_screen.dart';
import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:jiffy/jiffy.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _Stories()),
        SliverList(delegate: SliverChildBuilderDelegate(_delegate))
      ],
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
        Navigator.of(context).push(ChatSceen.route(messagedata));
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
                    SizedBox(
                      height: 20,
                      child: Text(messagedata.message,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textFaded)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      messagedata.dateMessage.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 11,
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textFaded),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                          color: AppColors.secondary, shape: BoxShape.circle),
                      child: const Center(
                        child: Text(
                          "1",
                          style: TextStyle(
                              fontSize: 10, color: AppColors.textLigth),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SizedBox(
        height: 134.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
              child: Text("Stories",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: AppColors.textFaded)),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker = Faker();
                    return SizedBox(
                      width: 75,
                      child: _StoryCard(
                        storyData: StoryData(
                            name: faker.person.name(),
                            url: Helpers.randomPictureUrl()),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  final StoryData storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: storyData.url),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
