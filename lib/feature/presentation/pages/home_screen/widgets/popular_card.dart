import 'dart:ui';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PopularCard extends StatelessWidget {
  String tag;
  final TurfModel turfModel;
  PopularCard(
      {super.key,
      required this.screenWidth,
      required this.tag,
      required this.turfModel});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: screenWidth * 0.78,
      width: screenWidth * 0.68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        //color: cardBgColor,
        gradient: linearGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        //sspacing: 10,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(
                () => ScreenItemView(
                  tag: tag,
                  turfmodel: turfModel,
                  type: ActionTypeFrom.noStar,
                ),
                transition: Transition.circularReveal,
                duration: Duration(milliseconds: 800),
              );
            },
            child: SizedBox(
              height: 170,
              width: double.infinity,
              child: Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cardRadius),
                  child: Image.network(
                    fit: BoxFit.cover,
                    turfModel.images[0],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            overflow: TextOverflow.ellipsis,
            turfModel.turfName,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
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
          //Book button-----------------------
          Align(
            alignment: Alignment.bottomRight,
            child: CustomButton(
              onTap: () {
                context.read<ItemViewBloc>().add(GoogleMapLauncherEvent(
                    position: "${turfModel.latitude},${turfModel.longitude}"));
              },
              text: "View",
              width: 80,
              height: 30,
              color: buttonColor,
              radius: 7,
              textStyle: TextStyle(color: kWhite, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
