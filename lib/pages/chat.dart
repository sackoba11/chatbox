import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Chatmessage extends StatelessWidget {
  final String? imageUrl;

  const Chatmessage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider provider = CachedNetworkImageProvider(imageUrl!);
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: provider,
            width: w,
            //height: h,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
