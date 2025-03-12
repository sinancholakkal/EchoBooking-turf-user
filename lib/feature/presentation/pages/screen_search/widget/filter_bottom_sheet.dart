import 'dart:developer';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

PersistentBottomSheetController filterBottumSheet({
  required BuildContext context,
  required ValueNotifier<String?> date,
  required ValueNotifier<String?> time,
  required TextEditingController searchController,
  required ValueNotifier<int?> selectedChipIndex,
  required RangeValues currentRangeValues,
  required List<String> choiceList,
}) {
  return showBottomSheet(
    elevation: 20,
    backgroundColor: const Color.fromARGB(255, 14, 11, 59),
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: 600,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: kWhite,
                          )),
                          Spacer(),
                          OutlinedButton(onPressed: (){
                      selectedChipIndex.value = null;
                      date.value = null;
                      time.value = null;
                    }, child: Text("Clear")),
                    width10,
                      //Done button-----------
                      OutlinedButton(
                          onPressed: () {
                            //selectedChipIndex.value = selectedChipIndex.value;
                            searchController.text =
                                (selectedChipIndex.value != null)
                                    ? choiceList[selectedChipIndex.value!]
                                    : searchController.text;
                            context
                                .read<SearchBloc>()
                                .add(SearchQueryEvent(searchQuery: {
                                  "search": searchController.text,
                                  "startprice":
                                      currentRangeValues.start.toString(),
                                  "endprice": currentRangeValues.end.toString(),
                                  "date": date.value ?? "null",
                                  "time": time.value ?? "null",
                                }));
                            Get.back();
                            log(date.toString());
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(color: kWhite),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextWidget(text: "Price"),
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    currentRangeValues = (state is RangeValueLoadedState)
                        ? state.rangeValue
                        : currentRangeValues;
                    return Column(
                      children: [
                        RangeSlider(
                          min: 0,
                          max: 2000,
                          divisions: 10,
                          values: currentRangeValues,
                          labels: RangeLabels(
                            currentRangeValues.start.round().toString(),
                            currentRangeValues.end.round().toString(),
                          ),
                          onChanged: (value) {
                            context
                                .read<SearchBloc>()
                                .add(RangeValueEvent(rangeValue: value));
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text:
                                    currentRangeValues.start.toInt().toString(),
                                size: 18,
                              ),
                              TextWidget(
                                text: currentRangeValues.end.toInt().toString(),
                                size: 18,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                  child: TextWidget(text: "Category"),
                ),
                //category choice chip--------
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ValueListenableBuilder<int?>(
                    valueListenable: selectedChipIndex,
                    builder: (context, selectedIndex, child) {
                      return Wrap(
                        spacing: 10,
                        children: List.generate(choiceList.length, (index) {
                          return ChoiceChip(
                            label: Text(choiceList[index]),
                            selected: selectedIndex == index,
                            onSelected: (value) {
                              selectedChipIndex.value = value ? index : null;
                            },
                            checkmarkColor: Colors.white,
                            selectedColor: Colors.grey[850],
                            backgroundColor: Colors.black,
                            labelStyle: TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                //Date picking-------
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                  child: TextWidget(text: "Date"),
                ),

                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is DatePickerSuccessState) {
                      date.value = state.date;
                    }
                    return ValueListenableBuilder(
                      valueListenable: date,
                      builder: (context, dateValue, child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextWidget(
                            text: dateValue ?? "No date selected",
                            fontWeight: FontWeight.normal,
                            size: 18,
                          ),
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: OutlinedButton(
                      onPressed: () {
                        context
                            .read<SearchBloc>()
                            .add(DatePickerEvent(context: context));
                      },
                      child: TextWidget(
                        text: "Select Date",
                        fontWeight: FontWeight.normal,
                        size: 18,
                      )),
                ),
                //Time Picker----------
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                  child: TextWidget(text: "From Time"),
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is TimePickerSuccessState) {
                      time.value = "${state.hour}:${state.minute}";
                    }
                    return ValueListenableBuilder(
                      valueListenable: time,
                      builder: (context, timeValue, child) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextWidget(
                            text: timeValue ?? "No time selected",
                            fontWeight: FontWeight.normal,
                            size: 18,
                          ),
                        );
                      },
                    );
                  },
                ),
                OutlinedButton(
                    onPressed: () {
                      if (date.value != null) {
                        context
                            .read<SearchBloc>()
                            .add(TimePickerEvent(context: context));
                      }
                    },
                    child: TextWidget(
                      text: "Select Time",
                      color: date.value != null ? kWhite : Colors.grey,
                      fontWeight: FontWeight.normal,
                      size: 18,
                    )),
                    height10,
                    
              ],
            ),
          );
        },
      );
    },
  );
}
