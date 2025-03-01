import 'dart:developer';

import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/turf_bloc/turf_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/circular_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TurfDisplayPartWidget extends StatelessWidget {
  const TurfDisplayPartWidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return BlocBuilder<TurfBloc, TurfState>(
            builder: (context, state) {
              if(state is TurfFetchLoadingState){
                return CircularWidget();
              }else if(state is TurfFetchLoadedState){
                List<TurfModel> turfs = [...state.turfModels[0],...state.turfModels[1]];
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
              }else{
                return SizedBox();
              }
            }
          );
        }
        //Loading state-----------
        else if (state is SearchLoadingState) {
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
    );
  }
}
