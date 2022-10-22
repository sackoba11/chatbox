import 'package:chatbox/helpers.dart';
import 'package:chatbox/models/models.dart';
import 'package:chatbox/models/story_data.dart';
import 'package:chatbox/theme.dart';
import 'package:chatbox/widgets/avatar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _Stories(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            _delegate,
          ),
        )
      ],
    );
  }

  Widget _delegate(BuildContext context, int index) {
    final Faker faker = Faker();

    return Text('test');
        
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({super.key, required messageData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar.medium(url: Url ,),
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
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 16),
              child: Text(
                'Stories',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  color: AppColors.textFaded,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final faker = Faker();
                    return Padding(
                      // revoir pour la taille du bas
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        width: 60,
                        child: _StoryCard(
                          storyData: StoryData(
                              name: faker.person.name(),
                              url: Helpers.randomPictureUrl()),
                        ),
                      ),
                    );
                  }),
            ),
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
