import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/turf_bloc/turf_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/football_sction.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/list_of_turf_section.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/popular_card_section.dart';
import 'package:echo_booking/feature/presentation/widgets/circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
class HomeTab extends StatefulWidget {
  HomeTab({super.key});
  @override
  State<HomeTab> createState() => _HomeTabState();
}
class _HomeTabState extends State<HomeTab> {
  int max = 5;
  bool visibilityMore = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: bloc.BlocBuilder<TurfBloc, TurfState>(
        builder: (context, state) {
          if (state is TurfFetchLoadingState) {
            return CircularWidget();
          } else if (state is TurfFetchLoadedState) {
            final List<TurfModel> footballTurfs = state.turfModels[0];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Popular section
                PopularCardSection(
                  screenWidth: screenWidth,
                  popular: state.turfModels[2],
                ),
                //Football turfs-------------------------
                FootballSection(
                  footballTurfs: footballTurfs,
                  max: max,
                  screenWidth: screenHeight,
                  visibilityMore: visibilityMore,
                ),
                //List of turfs
                ListOfTurfSection(screenWidth: screenWidth,turfModels: state.turfModels[1],)
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}







