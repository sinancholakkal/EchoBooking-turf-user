import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_heading.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/popular_card.dart';
import 'package:flutter/material.dart';

class PopularCardSection extends StatelessWidget {
  List<TurfModel> popular;
  PopularCardSection({
    super.key,
    required this.screenWidth,
    required this.popular,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          height10,
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CardHead(
              text: popularText,
            ),
          ),
          height10,
          // popular card==================================
          SizedBox(
            height: screenWidth * 0.78,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: PopularCard(
                    turfModel: popular[index],
                    screenWidth: screenWidth,
                    tag: "popular_item_view$index",
                  ),
                );
              },
              itemCount: popular.length,
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}