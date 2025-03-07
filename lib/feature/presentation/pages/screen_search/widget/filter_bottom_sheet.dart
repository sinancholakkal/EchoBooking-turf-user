import 'dart:developer';

import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

PersistentBottomSheetController filterBottumSheet({
  required BuildContext context,
  required String? date,
  required String? time,
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
            height: 500,
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
                      //Done button-----------
                      TextButton(
                          onPressed: () {
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
                                  "endprice":
                                      currentRangeValues.end.toString(),
                                  "date": date ?? "null",
                                  "time": time ?? "null",
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
                    return RangeSlider(
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
                      date = state.date;
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextWidget(
                        text: (date != null) ? date! : "No date selected",
                        fontWeight: FontWeight.normal,
                        size: 18,
                      ),
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
                      time = "${state.hour}:${state.minute}";
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextWidget(
                        text: (time != null) ? time! : "No time selected",
                        fontWeight: FontWeight.normal,
                        size: 18,
                      ),
                    );
                  },
                ),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    return OutlinedButton(
                        onPressed: () {
                          if ((state is DatePickerSuccessState ||
                              state is TimePickerSuccessState)) {
                            context
                                .read<SearchBloc>()
                                .add(TimePickerEvent(context: context));
                          }
                        },
                        child: TextWidget(
                          text: "Select Time",
                          color: (state is DatePickerSuccessState ||
                                  state is TimePickerSuccessState)
                              ? kWhite
                              : Colors.grey,
                          fontWeight: FontWeight.normal,
                          size: 18,
                        ));
                  },
                )
              ],
            ),
          );
        },
      );
    },
  );
}
