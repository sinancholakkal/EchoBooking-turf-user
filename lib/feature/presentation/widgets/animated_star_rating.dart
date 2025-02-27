import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';

class AnimatedStarRatingWidget extends StatelessWidget {
  final double starSize;
  final double initial;
  final bool readOnly;
   Function(double) onChanged;
   AnimatedStarRatingWidget({
    super.key,
    required  this.onChanged,
    required this.initial,
    this.readOnly = false,
    this.starSize =30,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedRatingStars(
      starSize: starSize,
      readOnly: readOnly,
      initialRating: initial,
      minRating: 0.0,
      maxRating: 5.0,
      filledColor: Colors.amber,
      emptyColor: Colors.grey,
      filledIcon: Icons.star,
      halfFilledIcon: Icons.star_half,
      emptyIcon: Icons.star_border,
      onChanged: onChanged,
      customFilledIcon: Icons.star,
      customHalfFilledIcon: Icons.star_half,
      customEmptyIcon: Icons.star_border,
    );
  }
}
