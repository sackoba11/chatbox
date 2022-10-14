import 'package:chatbox/helpers.dart';
import 'package:chatbox/models/story_data.dart';
import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

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
    return Text("test");
  }
}

class MessagesTitle extends StatelessWidget {
  const MessagesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //  Avatar.medium(url: url,);
      ],
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
