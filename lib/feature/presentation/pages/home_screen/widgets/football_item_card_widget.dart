import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FootballItemCardWidget extends StatelessWidget {
  int index;
  final TurfModel turfModel;
  FootballItemCardWidget(
      {super.key,
      required this.screenWidth,
      required this.index,
      required this.turfModel});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(
              () => ScreenItemView(
                    type: ActionTypeFrom.noStar,
                    turfmodel: turfModel,
                    tag: "category_item_view$index",
                  ),
              transition: Transition.circularReveal,
              duration: Duration(milliseconds: 800));
        },
        child: Container(
          width: screenWidth * 0.45,
          height: screenWidth * .70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cardRadius),
            gradient: linearGradient,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            //sspacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Hero(
                  tag: "category_item_view$index",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cardRadius),
                    child: Image.network(
                      height: screenWidth * .50,
                      fit: BoxFit.cover,
                      turfModel.images[0],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  turfModel.turfName,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: kWhite),
                ),
              ),
              Row(
                // mainAxisSize: MainAxisSize.max,

                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Text(
                      turfModel.landmark,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kGrey,
                      ),
                    ),
                  ),
                ],
              ),
              height10,
            ],
          ),
        ),
      ),
    );
  }
}
