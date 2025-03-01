import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/turf_bloc/turf_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_search/widget/search_top_items_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_search/widget/turf_display_part_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});
  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}
class _ScreenSearchState extends State<ScreenSearch> {
  late TextEditingController _searchController;
  RangeValues _currentRangeValues = const RangeValues(500, 2000);
  ValueNotifier<int?> selectedChipIndex = ValueNotifier<int?>(null);
  List<String> choiceList = [
    "Football",
    "Cricket",
    "Otheres",
  ];
  @override
  void initState() {
    context.read<TurfBloc>().add(TurfFetchEvent());
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
          //Top itemes(Back arrow, Search field, Text to speech and filter icon).............
          SearchTopItemsWidget(
              searchController: _searchController,
              choiceList: choiceList,
              currentRangeValues: _currentRangeValues,
              selectedChipIndex: selectedChipIndex),
          //Display turfs(Initial turfs and search results)-----------
          TurfDisplayPartWidget(screenWidth: screenWidth)
        ],
      )),
    );
  }
}

