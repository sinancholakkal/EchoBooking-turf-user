import 'dart:developer';

import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/search_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_search/widget/filter_bottom_sheet.dart';
import 'package:echo_booking/feature/presentation/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SearchTopItemsWidget extends StatelessWidget {
  const SearchTopItemsWidget({
    super.key,
    required TextEditingController searchController,
    required this.choiceList,
    required RangeValues currentRangeValues,
    required this.selectedChipIndex,
  }) : _searchController = searchController, _currentRangeValues = currentRangeValues;

  final TextEditingController _searchController;
  final List<String> choiceList;
  final RangeValues _currentRangeValues;
  final ValueNotifier<int?> selectedChipIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        //Speech to text button-----------------
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
                    filterBottumSheet(
                      context: context,
                      date: date,
                      time: time,
                      searchController: _searchController,
                      choiceList: choiceList,
                      currentRangeValues: _currentRangeValues,
                      selectedChipIndex: selectedChipIndex,
                    );
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
    );
  }
}
