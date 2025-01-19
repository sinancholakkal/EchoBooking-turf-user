import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/home_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  double tabOpacity = 1;
  double tabRadius = 20;
  bool iconVisible = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: backGroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
        
                // backgroundColor: Colors.black,
                // expandedHeight: 150.0,
                // floating: false,
                // pinned: true,
                toolbarHeight: kTabLabelPadding.horizontal,
                expandedHeight: screenHeight *0.20,
                floating: false,
                pinned: true,
                backgroundColor: backGroundColor,
                primary: true,
                forceElevated: false,
        
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.05,
                            ),
                            // account icon button-----------------
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.account_circle,
                                  color: iconColorPerson,
                                  size: iconSizePerson,
                                ),
                              ),
                            ),
                            //search----------------
                            SizedBox(
                              height: 50,
                              child: CupertinoSearchTextField(
                                itemColor: Colors.white60,
                                itemSize: 26,
                                backgroundColor: searchBgColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(60.0),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: TabBar(
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: const Color.fromARGB(255, 41, 38, 236),
                        borderRadius: BorderRadius.circular(tabRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent,
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      labelColor: kWhite,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.home,color: homeIconColor,size: homeTabIconSize,),
                          text: "For You",
                        ),
                        Tab(
                          icon: Icon(Icons.bookmark_added,size: homeTabIconSize,color: bookingIconColor,),
                          text: "Booking",
                        ),
                        Tab(
                          icon: Icon(Icons.stars,size: homeTabIconSize,color:starIconColor,),
                          text: "Star",
                          
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              HomeTab(),
              Text(
                "22222222222222222",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "333333333333333333",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
