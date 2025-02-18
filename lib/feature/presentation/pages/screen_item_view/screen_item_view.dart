import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/data/repository/call_launcher.dart';
import 'package:echo_booking/feature/data/repository/whatsapp_launcher.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/expandeble_floating_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/star_animation.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenItemView extends StatefulWidget {
  String tag;
  ScreenItemView({super.key, required this.tag});

  @override
  State<ScreenItemView> createState() => _ScreenItemViewState();
}

class _ScreenItemViewState extends State<ScreenItemView> {
  int currentDobt = 0;
  Map<String, List<Map<String, dynamic>>> timeSlots = {
    "2025-02-16": [
      {"time": "2pm to 3pm"},
      {"time": "5pm to 6pm"}
    ],
    "2025-02-17": [
      {"time": "7pm to 8pm"},
      {"time": "8pm to 9pm"},
      {"time": "8pm to 9pm"},
      {"time": "8pm to 9pm"}
    ]
  };
  int selectedDateIndex = 0;
  @override
  void initState() {
    context.read<ItemViewBloc>().add(CarouselDoubt(currentDobt: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    List<String> dateKeys = timeSlots.keys.toList();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // carousal builder----------------
            CarouselSlider.builder(
              itemCount: 6,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  children: [
                    //carousal image displaying--------------------
                    Container(
                        width: screenWidth * 9,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(cardRadius)),
                        child: (index == 0)
                            ? Hero(
                                tag: widget.tag,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(cardRadius),
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    "https://imgs.search.brave.com/d9zLy3LpeCN68slQIY7sAcl_k-NmM0I3nFFBuaVGlOE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4LzUzLzU0LzEy/LzM2MF9GXzg1MzU0/MTI0MF85MHFuZVlE/YjNMSnhNRHczMzJr/TVJqcExuU1doeVRH/Qy5qcGc",
                                  ),
                                ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(cardRadius),
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  "https://imgs.search.brave.com/d9zLy3LpeCN68slQIY7sAcl_k-NmM0I3nFFBuaVGlOE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4LzUzLzU0LzEy/LzM2MF9GXzg1MzU0/MTI0MF85MHFuZVlE/YjNMSnhNRHczMzJr/TVJqcExuU1doeVRH/Qy5qcGc",
                                ),
                              )),
                    //veiw details button on the carousal------------------
                    Positioned(
                        right: 14,
                        bottom: 10,
                        child: CustomButton(
                            text: "View details",
                            width: 90,
                            height: 32,
                            textStyle: TextStyle(fontSize: 12, color: kWhite),
                            radius: 10,
                            color: kblue))
                  ],
                );
              },
              options: CarouselOptions(
                animateToClosest: true,
                aspectRatio: 19 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  context
                      .read<ItemViewBloc>()
                      .add(CarouselDoubt(currentDobt: index));
                },
                //autoPlay: true,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            //carousal dobts.............
            BlocBuilder<ItemViewBloc, ItemViewState>(
              builder: (context, state) {
                if (state is CarouselDoubtChangedState) {
                  return Center(
                    child: AnimatedSmoothIndicator(
                      effect: SlideEffect(
                        dotHeight: 5,
                        dotWidth: 5,
                        strokeWidth: 1.5,
                        paintStyle: PaintingStyle.stroke,
                      ),
                      activeIndex: state.currentDoubt,
                      count: 6,
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: "Mannarkkad Turf"),
                  SizedBox(
                    height: 65,
                    width: 65,
                    child: StarAnimation(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextWidget(
                text: "anamooli,mannarkkad",
                size: 15,
                color: Colors.grey,
              ),
            ),
            height10,
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextWidget(
                text: "₹960",
                fontWeight: FontWeight.bold,
              ),
            ),
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextWidget(
                text: "Includes",
                size: 18,
                color: Colors.white70,
              ),
            ),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: TextWidget(
                      text: "- Bat",
                      color: Colors.white70,
                      size: 18,
                    ),
                  );
                },
              ),
            ),

            height10,

            Column(
              children: [
                // Date Selector
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dateKeys.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDateIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: selectedDateIndex == index
                                ? Colors.blue.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                DateFormat('dd MMM').format(
                                    DateFormat('yyyy-MM-dd')
                                        .parse(dateKeys[index])),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: selectedDateIndex == index
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                              if (selectedDateIndex == index)
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  height: 4,
                                  width: 20,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Display Selected Date's Time Slots
                Wrap(
                  children: List.generate(
                    timeSlots[dateKeys[selectedDateIndex]]!.length,
                    (index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                            timeSlots[dateKeys[selectedDateIndex]]![index]
                                ["time"],
                            style: TextStyle(color: Colors.white)),
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Center(
                child: CustomButton(
              text: "Location",
              color: kblue,
              height: 55,
              radius: cardRadius,
              width: screenWidth * 0.9,
              textStyle: TextStyle(
                  color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
            )),
            height10,
            Center(
                child: CustomButton(
              text: "Book Now",
              color: kblue,
              height: 55,
              radius: cardRadius,
              width: screenWidth * 0.9,
              textStyle: TextStyle(
                  color: kWhite, fontSize: 18, fontWeight: FontWeight.bold),
            ))
          ],
        ),
      ),
      //floating action button
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandebleFloatingWidget(
        //call launcher
          callOntap: ()=>callLauncher(phone: "7025653318"),
          //whatsApp launcher
          whatsappOnTap: () => launchWhatsApp(phone: "9656138299")),
    );
  }


}
