import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/divider_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/rating_list_tile.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenViewAllReviews extends StatelessWidget {
  final List<dynamic> reviews;
  ScreenViewAllReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        iconTheme: IconThemeData(
          color: kWhite
        ),
        title: TextWidget(text: "All reviews"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: backGroundGradient),
        child: ListView.separated(
          itemBuilder: (context, index) {
            final Map<String,dynamic> data = reviews[index];
            return RatingListTileWidget(data: data);
          },
          separatorBuilder: (context, index) {
            return DividerWidget();
          },
          itemCount: reviews.length,
        ),
      ),
    );
  }
}
