import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/date_display_builder_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
List<Map<String, dynamic>> slots =[];
class DateAndTimeSlotWidget extends StatelessWidget {
  ValueNotifier<int?> selectedTimeSlotIndex;
  ValueNotifier<int> selectedDateIndex;
  Map<String, List<Map<String, dynamic>>> timeSlots;
  
  List<String> dateKeys;
  DateAndTimeSlotWidget({
    super.key,
    required this.selectedTimeSlotIndex,
    required this.dateKeys,
    required this.selectedDateIndex,
    required this.timeSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date Selector
        DateDisplayBuilderWidget(
            selectedTimeIndex: selectedTimeSlotIndex,
            dateKeys: dateKeys,
            selectedDateIndex: selectedDateIndex),
        // Display time slotes-------------------------
        ValueListenableBuilder(
          valueListenable: selectedDateIndex,
          builder: (context, selectDate, child) {
            slots = timeSlots[dateKeys[selectDate]] ?? [];
            return Align(
              alignment: Alignment.topLeft,
              child: ValueListenableBuilder(
                valueListenable: selectedTimeSlotIndex,
                builder: (context, selectTime, child) {
                  if (slots.isEmpty) {
                    return Center(
                      child: TextWidget(text: "No time slotes available now!"),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Wrap(
                          spacing: 10,
                          children: List.generate(slots.length, (index) {
                            return ChoiceChip(
                                checkmarkColor: kWhite,
                                selectedColor: Colors.grey[850],
                                labelStyle: TextStyle(
                                    color: slots[index]['isAvailable'] == false
                                        ? const Color.fromARGB(
                                            83, 158, 158, 158)
                                        : kWhite),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color:
                                            slots[index]['isAvailable'] == false
                                                ? const Color.fromARGB(
                                                    83, 158, 158, 158)
                                                : kWhite)),
                                label: Text(slots[index]['time']),
                                selected: selectTime == index,
                                onSelected: slots[index]['isAvailable'] == true
                                    ? (value) {
                                        selectedTimeSlotIndex.value =
                                            value ? index : null;
                                      }
                                    : (value) {});
                          })),
                    );
                  }
                },
              ),
            );
          },
        )
      ],
    );
  }
}
