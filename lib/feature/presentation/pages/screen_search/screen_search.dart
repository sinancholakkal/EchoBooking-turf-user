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
                    if (state.searchTurfs.isNotEmpty) {
                      return IconButton(
                          onPressed: () {
                            showBottomSheet(
                              elevation: 20,
                              backgroundColor: const Color.fromARGB(255, 14, 11, 59),
                              context: context,
                              builder: (context) {
                                RangeValues _tempRangeValues =
                                    _currentRangeValues;

                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    return SizedBox(
                                      height: 800,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed: () => Get.back(),
                                                    icon: Icon(
                                                      Icons.arrow_back,
                                                      color: kWhite,
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      context.read<SearchBloc>().add(
                            SearchQueryEvent(searchQuery: {"search": _searchController.text}));
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "Done",
                                                      style: TextStyle(
                                                          color: kWhite),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: TextWidget(text: "Price"),
                                          ),
                                          BlocBuilder<SearchBloc,
                                              SearchState>(
                                            builder: (context, state) {
                                              return RangeSlider(
                                                min: 0,
                                                max: 2000,
                                                divisions: 10,
                                                values: state is RangeValueLoadedState?state.rangeValue:_currentRangeValues,
                                                labels: RangeLabels(
                                                  _tempRangeValues.start
                                                      .round()
                                                      .toString(),
                                                  _tempRangeValues.end
                                                      .round()
                                                      .toString(),
                                                ),
                                                onChanged: (value) {
                                                  context
                                                      .read<SearchBloc>()
                                                      .add(RangeValueEvent(
                                                          rangeValue: value));
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                            ;
                          },
                          icon: Icon(
                            Icons.filter_alt,
                            color: kWhite,
                            size: 30,
                          ));
                    } else {
                      return SizedBox();
                    }
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
}
