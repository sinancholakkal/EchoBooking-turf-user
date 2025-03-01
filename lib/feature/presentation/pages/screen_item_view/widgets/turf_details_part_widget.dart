import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/includes_builder_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/star_animation.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TurfDetailsPartWidget extends StatelessWidget {
  const TurfDetailsPartWidget({
    super.key,
    required this.widget,
    required this.timeSlots,
    required this.isFav,
  });

  final ScreenItemView widget;
  final Map<String, List<Map<String, dynamic>>> timeSlots;
  final bool? isFav;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          //Turf name---------
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: widget.turfmodel.turfName,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 65,
                  width: 65,
                  child: StarAnimation(
                    timeSlots: timeSlots,
                    turfModel: widget.turfmodel,
                    isFav: isFav!,
                  ),
                )
              ],
            ),
          ),
          //Ladmark displaying-----------------
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                text: (!widget.turfmodel.landmark
                        .endsWith("kerala")
                    ? "${widget.turfmodel.landmark}, ${widget.turfmodel.state}"
                    : widget.turfmodel.landmark),
                size: 17,
                maxLine: 3,
                color: Colors.grey,
              ),
            ),
          ),
          height10,
          height10,
          //Price------------------
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0),
              child: TextWidget(
                text:
                    "₹${widget.turfmodel.price}",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          height10,
          //includes display part==================
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0),
              child: TextWidget(
                text: "Includes",
                size: 18,
                color: Colors.white70,
              ),
            ),
          ),
          IncludesBuilderWidget(widget: widget),
          height10,
        ],
      ),
    );
  }
}
