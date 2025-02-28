
import 'package:echo_booking/feature/presentation/widgets/animated_star_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingListTileWidget extends StatelessWidget {
  const RatingListTileWidget({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: data['name'],
            size: 18,
            color: Colors.white60,
          ),
          Row(
            spacing: 6,
            children: [
              AnimatedStarRatingWidget(
                onChanged: (val) {},
                initial: double.parse(data['star']),
                starSize: 10,
                readOnly: true,
              ),
              TextWidget(
                text: data['star'],
                size: 13,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          TextWidget(
            text: data['command'],
            maxLine: 10,
            size: 15,
          )
        ],
      ),
    );
  }
}
