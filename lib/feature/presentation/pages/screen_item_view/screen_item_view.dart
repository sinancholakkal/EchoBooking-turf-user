import 'package:carousel_slider/carousel_slider.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/star_animation.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ScreenItemView extends StatefulWidget {
  String tag;
   ScreenItemView({super.key,required this.tag});

  @override
  State<ScreenItemView> createState() => _ScreenItemViewState();
}

class _ScreenItemViewState extends State<ScreenItemView> {
  int currentDobt = 0;
  @override
  void initState() {
    context.read<ItemViewBloc>().add(CarouselDoubt(currentDobt: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                        child: (index==0)?Hero(tag: widget.tag, child: ClipRRect(
                          borderRadius: BorderRadius.circular(cardRadius),
                          child: Image.network(
                            fit: BoxFit.cover,
                            "https://imgs.search.brave.com/d9zLy3LpeCN68slQIY7sAcl_k-NmM0I3nFFBuaVGlOE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4LzUzLzU0LzEy/LzM2MF9GXzg1MzU0/MTI0MF85MHFuZVlE/YjNMSnhNRHczMzJr/TVJqcExuU1doeVRH/Qy5qcGc",
                          ),
                        )):
                        
                        ClipRRect(
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
                          color: const Color.fromARGB(255, 27, 70, 199),
                        ))
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
            SizedBox(
              height: 20,
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
                text: "₹960",
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
