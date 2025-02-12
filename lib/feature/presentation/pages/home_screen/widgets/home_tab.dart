import 'dart:developer';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_heading.dart';
import 'package:echo_booking/feature/presentation/pages/screen_account/widget/profile_card_widget.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'popular_card.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int length = 10;

  int max = 5;
  bool visibilityMore = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
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
                    screenWidth: screenWidth,
                    tag: "popular_item_view$index",
                  ),
                );
              },
              itemCount: 4,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CardHead(
              text: footballText,
            ),
          ),
          Wrap(
            children: List.generate(
              //max<length?max:length,
              length < max ? length + 1 : max,
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
                              if (max + 4 > length) {
                                max = length + 1;
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
                  return CategoryItemCardWidget(screenWidth: screenWidth,index:index);
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
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                child: GestureDetector(
                  onTap: (){
                    Get.to(()=>ScreenItemView(tag: "list_item_view$index",),transition: Transition.cupertino,duration: Duration(milliseconds: 800));
                  },
                  child: Container(
                    height: profilecardHeight,
                    width: screenWidth * .85,
                    decoration: BoxDecoration(
                        gradient: linearGradient,
                        borderRadius: BorderRadius.circular(profilecardRadius)),
                    child: Row(
                      children: [
                        Hero(
                          tag: "list_item_view$index",
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 14),
                            width: screenWidth * .23,
                            height: screenWidth * .23,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(profilecardRadius),
                              //color: Colors.grey,
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(profilecardRadius),
                              child: Image.network(
                                fit: BoxFit.cover,
                                "https://imgs.search.brave.com/d9zLy3LpeCN68slQIY7sAcl_k-NmM0I3nFFBuaVGlOE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4LzUzLzU0LzEy/LzM2MF9GXzg1MzU0/MTI0MF85MHFuZVlE/YjNMSnhNRHczMzJr/TVJqcExuU1doeVRH/Qy5qcGc",
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 3,
                          children: [
                            TextWidget(
                              text: "Hiiii",
                              color: kWhite,
                              size: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              width: screenWidth * 0.5,
                              child: TextWidget(
                                text: "hello",
                                color: Colors.grey,
                                size: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class CategoryItemCardWidget extends StatelessWidget {
  int index;
   CategoryItemCardWidget({
    super.key,
    required this.screenWidth,
    required this.index
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: GestureDetector(
        onTap: (){
          Get.to(()=>ScreenItemView(tag: "category_item_view$index",),transition: Transition.cupertino,duration: Duration(milliseconds: 800));
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
                      "https://imgs.search.brave.com/d9zLy3LpeCN68slQIY7sAcl_k-NmM0I3nFFBuaVGlOE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4LzUzLzU0LzEy/LzM2MF9GXzg1MzU0/MTI0MF85MHFuZVlE/YjNMSnhNRHczMzJr/TVJqcExuU1doeVRH/Qy5qcGc",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Mannarkkad Turf",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: kWhite),
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
                      "parampulli,palakkad, dsjhdksjhljkaslkj",
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
