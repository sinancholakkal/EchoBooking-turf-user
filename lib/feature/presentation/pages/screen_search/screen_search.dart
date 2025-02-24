import 'dart:developer';

import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/search_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/flutter_toast.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  late TextEditingController _searchController;
  RangeValues _currentRangeValues = const RangeValues(100, 1000);
  ValueNotifier<int?> selectedChipIndex = ValueNotifier<int?>(null);
  List<String> choiceList = [
    "Football",
    "Cricket",
    "Otheres",
  ];
  @override
  void initState() {
    _searchController = TextEditingController();
    context.read<SearchBloc>().add(SearchResetEvent());
    super.initState();
    context.read<SearchBloc>().add(SpeechToTextInitial());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: kWhite,
                  )),
              BlocConsumer<SearchBloc, SearchState>(
                listener: (context, state) {
                  if (state is SpeachLoadingState) {
                    flutterToast(msg: "Speech Listening...");
                    log("Speech listening...");
                  }
                },
                builder: (context, state) {
                  if (state is SpeechLoadedState) {
                    _searchController.text = state.text;
                  }
                  return Flexible(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SearchWidget(
                      enable: true,
                      controller: _searchController,
                      onTapMove: false,
                      width: 280,
                      onSubmitted: (value) {
                        _searchController.text = value;
                        log("On sumbmit called");
                        context.read<SearchBloc>().add(
                            SearchQueryEvent(searchQuery: {"search": value}));
                      },
                    ),
                  ));
                },
              ),
              IconButton(
                  onPressed: () {
                    context
                        .read<SearchBloc>()
                        .add(SpeechToTextStartListerning());
                  },
                  icon: Icon(
                    Icons.mic,
                    color: kWhite,
                    size: 30,
                  )),
              //Filter icon-------------------
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoadedState) {
                    return IconButton(
                        onPressed: () {
                          String? date;
                          String? time;
                          //Show  bottom sheet------
                          filterBottumSheet(context, date, time);
                        },
                        icon: Icon(
                          Icons.filter_alt,
                          color: kWhite,
                          size: 30,
                        ));
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              //Loading state-----------
              if (state is SearchLoadingState) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 380,
                      ),
                      CircularProgressIndicator(
                        color: kWhite,
                        strokeWidth: 1.5,
                      ),
                    ],
                  ),
                );
                //Loaded state-----------
              } else if (state is SearchLoadedState) {
                if (state.searchTurfs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 380,
                        ),
                        TextWidget(text: "No data found"),
                      ],
                    ),
                  );
                } else {
                  List<TurfModel> turfs = state.searchTurfs;
                  return Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 20),
                      child: ListView.builder(
                        itemCount: turfs.length,
                        itemBuilder: (context, index) {
                          log(turfs.length.toString());
                          return CardTurfsWidget(
                              type: ActionTypeFrom.noStar,
                              screenWidth: screenWidth,
                              turfModel: turfs[index],
                              index: index,
                              heroTag: "search$index");
                        },
                      ),
                    ),
                  );
                }
              } else {
                return SizedBox();
              }
            },
          )
        ],
      )),
    );
  }

  PersistentBottomSheetController filterBottumSheet(
      BuildContext context, String? date, String? time) {
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
                              _searchController.text =
                                  (selectedChipIndex.value != null)
                                      ? choiceList[selectedChipIndex.value!]
                                      : _searchController.text;
                              context
                                  .read<SearchBloc>()
                                  .add(SearchQueryEvent(searchQuery: {
                                    "search": _searchController.text,
                                    "startprice":
                                        _currentRangeValues.start.toString(),
                                    "endprice":
                                        _currentRangeValues.end.toString(),
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
                      _currentRangeValues = (state is RangeValueLoadedState)
                          ? state.rangeValue
                          : _currentRangeValues;
                      return RangeSlider(
                        min: 0,
                        max: 2000,
                        divisions: 10,
                        values: _currentRangeValues,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
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
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 5),
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
                          children: List.generate(3, (index) {
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
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 5),
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
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 5),
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
                            if((state is DatePickerSuccessState || state is TimePickerSuccessState)){
                              context
                                .read<SearchBloc>()
                                .add(TimePickerEvent(context: context));
                            }
                            
                          },
                          child: TextWidget(
                            text: "Select Time",color: (state is DatePickerSuccessState || state is TimePickerSuccessState)?kWhite:Colors.grey,
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
}
