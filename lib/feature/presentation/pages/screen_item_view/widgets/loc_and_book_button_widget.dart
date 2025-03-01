import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_booking/screen_booking.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/time_slot_part_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

class LocAndBookButtonWidget extends StatelessWidget {
  const LocAndBookButtonWidget({
    super.key,
    required this.widget,
    required this.screenWidth,
    required this.selectedTimeSlotIndex,
    required this.dateKeys,
    required this.selectedDateIndex,
  });

  final ScreenItemView widget;
  final double screenWidth;
  final ValueNotifier<int?> selectedTimeSlotIndex;
  final List<String> dateKeys;
  final ValueNotifier<int> selectedDateIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          height20,
          //Location button-------------------
          Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                onTap: () {
                  context
                      .read<ItemViewBloc>()
                      .add(GoogleMapLauncherEvent(
                          position:
                              "${widget.turfmodel.latitude},${widget.turfmodel.longitude}"));
                },
                text: "Location",
                color: kblue,
                height: 55,
                radius: cardRadius,
                width: screenWidth * 0.9,
                textStyle: TextStyle(
                    color: kWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          height10,
          //Booking button--------------
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomButton(
              onTap: () {
                if (selectedTimeSlotIndex.value ==
                    null) {
                  flutterToast(
                      msg: "Select Time",
                      color: kGrey);
                } else {
                  Get.to(
                      () => ScreenBooking(
                            turfModel:
                                widget.turfmodel,
                            time: slots[
                                selectedTimeSlotIndex
                                    .value!]['time'],
                            dateKey: dateKeys[
                                selectedDateIndex
                                    .value],
                          ),
                      transition:
                          Transition.cupertino);
                }
              },
              text: "Book Now",
              color: kblue,
              height: 55,
              radius: cardRadius,
              width: screenWidth * 0.9,
              textStyle: TextStyle(
                  color: kWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
