import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final String? initiales;
  final double? radius;
  const CustomImage({Key? key, this.imageUrl, this.initiales, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return CircleAvatar(
        radius: radius ?? 0.0,
        backgroundColor: Colors.blue,
        child: Text(
          initiales ?? "",
          style: TextStyle(color: Colors.white, fontSize: radius),
        ),
      );
    } else {
      ImageProvider provider = CachedNetworkImageProvider(imageUrl!);
      if (radius == null) {
        //images dans le chat
        return Image(
          image: provider,
          width: 250,
        );
      } else {
        //images dans profil
        return CircleAvatar(
          radius: radius,
          backgroundImage: provider,
        );
      }
    }
  }
}
