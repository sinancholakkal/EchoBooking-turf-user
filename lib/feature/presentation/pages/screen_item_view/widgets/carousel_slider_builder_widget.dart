import 'package:carousel_slider/carousel_slider.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselSlideBuilderWidget extends StatelessWidget {
  const CarouselSlideBuilderWidget({
    super.key,
    required this.widget,
    required this.screenWidth,
  });

  final dynamic widget;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.turfmodel.images.length,
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
                            widget.turfmodel.images[index],
                          ),
                        ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(cardRadius),
                        child: Image.network(
                          fit: BoxFit.cover,
                          widget.turfmodel.images[index],
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
    );
  }
}
