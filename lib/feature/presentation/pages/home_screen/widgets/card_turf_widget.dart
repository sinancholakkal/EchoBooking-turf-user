import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/star_bloc/star_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/booking_turf_view/screen_booking_turf_view.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

class CardTurfsWidget extends StatelessWidget {
  final ActionTypeFrom type;
  final dynamic turfModel;
  int index;
  String heroTag;
  CardTurfsWidget({
    super.key,
    required this.screenWidth,
    required this.turfModel,
    required this.index,
    required this.heroTag,
    required this.type,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          if (ActionTypeFrom.booking == type) {
            Get.to(()=>ScreenBookingTurfView(tag:heroTag,turfmodel: turfModel,));
          } else {
            Get.to(
                () => ScreenItemView(
                      type: type,
                      turfmodel: turfModel,
                      tag: heroTag,
                    ),
                transition: Transition.circularReveal,
                duration: Duration(milliseconds: 800));
          }
        },
        child: Container(
          height: profilecardHeight,
          width: screenWidth * .85,
          decoration: BoxDecoration(
              gradient: linearGradient,
              borderRadius: BorderRadius.circular(profilecardRadius)),
          child: Row(
            children: [
              Hero(
                tag: heroTag,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  width: screenWidth * .23,
                  height: screenWidth * .23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(profilecardRadius),
                    //color: Colors.grey,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(profilecardRadius),
                    child: Image.network(
                      fit: BoxFit.cover,
                      turfModel.images[0],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: screenWidth * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 3,
                    children: [
                      TextWidget(
                        text: turfModel.turfName,
                        color: kWhite,
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: TextWidget(
                          text: turfModel.landmark,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ),
                       (ActionTypeFrom.booking==type)?TextWidget(
                        text: turfModel.status,
                        color: (turfModel.status=="Closed")?Colors.red:Colors.green,
                        size: 14,
                        fontWeight: FontWeight.bold,
                      ):SizedBox()
                         
                    ],
                  ),
                ),
              ),
              (ActionTypeFrom.star == type)
                  ? PopupMenuButton(
                      iconColor: kWhite,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () => context.read<StarBloc>().add(
                              RemoveTurfStarEvent(turfId: turfModel.turfId)),
                          child: Text("Remove"),
                        ),
                      ],
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

enum ActionTypeFrom { star, noStar, booking }
