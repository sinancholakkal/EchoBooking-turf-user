import 'dart:developer';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/bloc/turf_bloc/turf_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_heading.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_account/widget/profile_card_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';

import '../widgets/popular_card.dart';

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
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TurfFetchLoadedState) {
            final List<TurfModel> footballTurfs = state.turfModels[0];
            // log(footballTurfs.toString());
            //log(state.turfModels[2][0].turfId);
            log("hhhhhhhhhhhhhhhhhhhhh");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height10,
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CardHead(
                    text: popularText,
                  ),
                ),
                height10,
                // popular card==================================
                SizedBox(
                  height: screenWidth * 0.78,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: PopularCard(
                          turfModel: (index == 0)
                              ? state.turfModels[0].last
                              : (index == 1)
                                  ? state.turfModels[1].last
                                  : state.turfModels[1].first,
                          screenWidth: screenWidth,
                          tag: "popular_item_view$index",
                        ),
                      );
                    },
                    itemCount: 3,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                //Football turfs-------------------------
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CardHead(
                    text: footballText,
                  ),
                ),
                Wrap(
                  children: List.generate(
                    //max<length?max:length,
                    footballTurfs.length < max ? footballTurfs.length + 1 : max,
                    (index) {
                      log(index.toString());
                      if (index == max - 1) {
                        log("show more===================");
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (max + 4 > footballTurfs.length) {
                                      max = footballTurfs.length + 1;
                                      visibilityMore = false;
                                    } else {
                                      max += 4;
                                    }
                                  });
                                },
                                child: Visibility(
                                  visible: visibilityMore,
                                  child: TextWidget(
                                    text: "Show more",
                                    color: kWhite,
                                    fontWeight: FontWeight.bold,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return FootballItemCardWidget(
                            turfModel: footballTurfs[index],
                            screenWidth: screenWidth,
                            index: index);
                      }
                    },
                  ),
                ),
                //List of turfs
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CardHead(
                    text: listOfTurf,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.turfModels[1].length,
                  itemBuilder: (context, index) {
                    return CardTurfsWidget(
                      screenWidth: screenWidth,
                      turfModel: state.turfModels[1][index],
                      index: index,
                      heroTag: "list_item_view$index",
                      type: ActionTypeFrom.noStar,
                    );
                  },
                )
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

class FootballItemCardWidget extends StatelessWidget {
  int index;
  final TurfModel turfModel;
  FootballItemCardWidget(
      {super.key,
      required this.screenWidth,
      required this.index,
      required this.turfModel});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(
              () => ScreenItemView(
                type: ActionTypeFrom.noStar,
                    turfmodel: turfModel,
                    tag: "category_item_view$index",
                  ),
              transition: Transition.circularReveal,
              duration: Duration(milliseconds: 800));
        },
        child: Container(
          width: screenWidth * 0.45,
          height: screenWidth * .70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cardRadius),
            gradient: linearGradient,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            //sspacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
                child: Hero(
                  tag: "category_item_view$index",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(cardRadius),
                    child: Image.network(
                      height: screenWidth * .50,
                      fit: BoxFit.cover,
                      turfModel.images[0],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  turfModel.turfName,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: kWhite),
                ),
              ),
              Row(
                // mainAxisSize: MainAxisSize.max,

                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Text(
                      turfModel.landmark,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: kGrey,
                      ),
                    ),
                  ),
                ],
              ),
              height10,
            ],
          ),
        ),
      ),
    );
  }
}
