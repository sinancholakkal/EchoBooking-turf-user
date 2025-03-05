import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_heading.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:flutter/material.dart';

class ListOfTurfSection extends StatelessWidget {
  List<TurfModel>turfModels;
   ListOfTurfSection({
    super.key,
    required this.screenWidth,
    required this.turfModels
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CardHead(
        text: listOfTurf,
      ),
    ),
    ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: turfModels.length,
      itemBuilder: (context, index) {
        return CardTurfsWidget(
          screenWidth: screenWidth,
          turfModel: turfModels[index],
          index: index,
          heroTag: "list_item_view$index",
          type: ActionTypeFrom.noStar,
        );
      },
    )
        ],
      ),
    );
  }
}