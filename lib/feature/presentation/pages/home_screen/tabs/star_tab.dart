import 'dart:developer';

import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/star_bloc/star_bloc.dart';
import 'package:echo_booking/feature/presentation/bloc/turf_bloc/turf_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StarTab extends StatefulWidget {
  const StarTab({super.key});

  @override
  State<StarTab> createState() => _StarTabState();
}

class _StarTabState extends State<StarTab> {
  @override
  void initState() {
    context.read<StarBloc>().add(FetchStarTurfsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<StarBloc, StarState>(
      builder: (context, state) {
        if(state is StarFetchingLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }else if(state is StarEmptyState){
          return Center(child: TextWidget(text: "Not yet",color: kWhite,),);
        }else if(state is StarFetchingLoadedState){
          return ListView.builder(
          itemCount: state.starTurfs.length,
          itemBuilder: (context, index) {
            log(state.starTurfs.length.toString());
            return CardTurfsWidget(
              type: ActionTypeFrom.star,
                screenWidth: screenWidth,
                turfModel: state.starTurfs[index],
                index: index,
                heroTag: "star$index");
          },
        );
        }else{
          return SizedBox();
        }
        
      },
    );
  }
}
