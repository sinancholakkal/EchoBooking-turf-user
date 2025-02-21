import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/feature/data/repository/call_launcher.dart';
import 'package:echo_booking/feature/data/repository/fetch_time_slotes.dart';
import 'package:echo_booking/feature/data/repository/whatsapp_launcher.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_dobts_builder.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/carousel_slider_builder_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/date_display_builder_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/expandeble_floating_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/includes_builder_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/star_animation.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class ScreenItemView extends StatefulWidget {
  String tag;
  final TurfModel turfmodel;
  final ActionTypeFrom type;
  ScreenItemView({super.key, required this.tag, required this.turfmodel,required this.type});

  @override
  State<ScreenItemView> createState() => _ScreenItemViewState();
}

class _ScreenItemViewState extends State<ScreenItemView> {
  int currentDobt = 0;
  ValueNotifier<int> selectedDateIndex = ValueNotifier(0);
  ValueNotifier<int?> selectedTimeSlotIndex = ValueNotifier<int?>(null);

  Future<bool>getStarIds()async{
     final resu = await FirebaseFirestore.instance
        .collection("userApp")
        .doc(AuthService().getCurrentUser()!.uid)
        .collection("star").get();
        final docs = resu.docs;
        return docs.any((doc) => doc.id == widget.turfmodel.turfId);
  }

  @override
  void initState() {
    context.read<ItemViewBloc>().add(CarouselDoubt(currentDobt: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(gradient: backGroundGradient),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // carousal builder----------------
              CarouselSlideBuilderWidget(
                  widget: widget, screenWidth: screenWidth),
              SizedBox(
                height: 4,
              ),
              //carousal dobts.............
              CarouselDobtsBuilderWidget(widget: widget),

              FutureBuilder(
                future: getStarIds(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(height: 200,),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                            bool? isFav = snapshot.data;
                            log(snapshot.data.toString());
                            return FutureBuilder(
                    future: fetchingTimeSlots(turfmodel: widget.turfmodel,type: widget.type),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Column(
                            children: [
                              SizedBox(height: 200,),
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        Map<String, List<Map<String, dynamic>>> timeSlots =
                            snapshot.data ?? {};
                        List<String> dateKeys = timeSlots.keys.toList();
                        
                          return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: widget.turfmodel.turfName,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 65,
                                      width: 65,
                                      child: StarAnimation(timeSlots: timeSlots,turfModel: widget.turfmodel,isFav: isFav!,),
                                    )
                                  ],
                                ),
                              ),
                              //Ladmark displaying-----------------
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextWidget(
                                  text: (!widget.turfmodel.landmark
                                          .endsWith("kerala")
                                      ? "${widget.turfmodel.landmark}, ${widget.turfmodel.state}"
                                      : widget.turfmodel.landmark),
                                  size: 17,
                                  maxLine: 3,
                                  color: Colors.grey,
                                ),
                              ),
                              height10,
                              height10,
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextWidget(
                                    text: "₹${widget.turfmodel.price}",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              height10,
                              //includes display part==================
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextWidget(
                                    text: "Includes",
                                    size: 18,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              IncludesBuilderWidget(widget: widget),
                
                              height10,
                              //Booking date displaying-------------------------
                              timeSlots.isEmpty?Center(child: TextWidget(text: "No time slotes available now!"),): Column(
                                children: [
                                  // Date Selector
                                 
                                  DateDisplayBuilderWidget(
                                      selectedTimeIndex: selectedTimeSlotIndex,
                                      dateKeys: dateKeys,
                                      selectedDateIndex: selectedDateIndex),
                
                                  // Display time slotes-------------------------
                                  ValueListenableBuilder(
                                    valueListenable: selectedDateIndex,
                                    builder: (context, selectDate, child) {
                                      List<Map<String, dynamic>> slots =
                                          timeSlots[dateKeys[selectDate]] ?? [];
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: ValueListenableBuilder(
                                          valueListenable: selectedTimeSlotIndex,
                                          builder: (context, selectTime, child) {
                                            if(slots.isEmpty){
                                              return Center(
                                                child: TextWidget(text: "No time slotes available now!"),
                                              );
                                            }else{
                                              return Padding(
                                              padding: EdgeInsets.only(left: 20),
                                              child: Wrap(
                                                  spacing: 10,
                                                  children: List.generate(
                                                      slots.length, (index) {
                                                    return ChoiceChip(
                                                      checkmarkColor: kWhite,
                                                      selectedColor:
                                                          Colors.grey[850],
                                                      labelStyle: TextStyle(
                                                          color: Colors.white),
                                                      backgroundColor:
                                                          Colors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              side: BorderSide(
                                                                  color: kWhite)),
                                                      label: Text(
                                                          slots[index]['time']),
                                                      selected:
                                                          selectTime == index,
                                                      onSelected: (value) {
                                                        selectedTimeSlotIndex
                                                                .value =
                                                            value ? index : null;
                                                      },
                                                    );
                                                  })
                                                  // return Container(
                                                  //   margin: EdgeInsets.all(8),
                                                  //   padding: EdgeInsets.all(12),
                                                  //   decoration: BoxDecoration(
                                                  //     color: Colors.grey[900],
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(10),
                                                  //   ),
                                                  //   child: Text(
                                                  //       timeSlots[dateKeys[value]]![index]
                                                  //           ["time"],
                                                  //       style: TextStyle(
                                                  //           color: Colors.white)),
                                                  // );
                
                                                  ),
                                            );
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              //Location button-------------------
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CustomButton(
                                    onTap: () {
                                      context.read<ItemViewBloc>().add(
                                          GoogleMapLauncherEvent(
                                              position:
                                                  "${widget.turfmodel.latitude},${widget.turfmodel.longitude}"));
                                    },
                                    text: "Location",
                                    color: kblue,
                                    height: 55,
                                    radius: cardRadius,
                                    width: screenWidth * 0.9,
                                    textStyle: TextStyle(
                                        color: kWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                              height10,
                              //Booking button--------------
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: CustomButton(
                                  text: "Book Now",
                                  color: kblue,
                                  height: 55,
                                  radius: cardRadius,
                                  width: screenWidth * 0.9,
                                  textStyle: TextStyle(
                                      color: kWhite,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        );
                        
                      } else {
                        return SizedBox();
                      }
                    });
                          }else{
                            return SizedBox();
                          }
                },
                
              )
            ],
          ),
        ),
      ),
      //floating action button
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandebleFloatingWidget(
          //call launcher
          callOntap: () => context
              .read<ItemViewBloc>()
              .add(CallLauncherEvent(phone: widget.turfmodel.phone)),
          //whatsApp launcher
          whatsappOnTap: () => context
              .read<ItemViewBloc>()
              .add(WhatsAppLauncher(phone: widget.turfmodel.phone))),
    );
  }
}
