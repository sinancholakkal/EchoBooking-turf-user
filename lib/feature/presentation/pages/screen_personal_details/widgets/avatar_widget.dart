import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
   AvatarWidget({
    super.key,
    required this.image
  });
  String image;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
