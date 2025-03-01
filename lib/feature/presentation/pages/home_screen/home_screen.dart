import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/user/user_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/tabs/booking_tab.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/tabs/home_tab.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/tabs/star_tab.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/tab_bar_icon_search_widget.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;

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
  void initState() {
     context.read<UserBloc>().add(UserDataFetchingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return bloc.BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if(state is UserLoadingState){
          return Scaffold(
            backgroundColor: backGroundColor,
          );
        }else if(state is UserLoadedState){
          String image = (state.user!.gender=="boy")?avatar[0]:avatar[1];
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
                    toolbarHeight: kTabLabelPadding.horizontal,
                    expandedHeight: 205,
                    floating: false,
                    pinned: true,
                    backgroundColor: backGroundColor,
                    primary: true,
                    forceElevated: false,

                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                            //Tab bar account icon and search field
                        child: TabBarIconSearchWidget(screenHeight: screenHeight, image: image),
                      ),
                    ),
                    //Bottom tab bar items------------
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(60.0),
                      child: TabBarWidget(screenWidth: screenWidth, tabRadius: tabRadius),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  HomeTab(),
                  BookingTab(),
                  StarTab(),
                ],
              ),
            ),
          
          ),
        );
        }else{
          return SizedBox();
        }
        
      },
    );
  }
}

