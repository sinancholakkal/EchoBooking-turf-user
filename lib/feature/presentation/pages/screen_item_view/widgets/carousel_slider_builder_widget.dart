import 'package:carousel_slider/carousel_slider.dart';
import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
        return GestureDetector(
          onTap: () {
            _openFullScreen(context, index);
          },
          child: Container(
            width: screenWidth * 9,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(cardRadius),
            ),
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
                  )
          ),
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
          context.read<ItemViewBloc>().add(CarouselDoubt(currentDobt: index));
        },
      ),
    );
  }

  void _openFullScreen(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageViewer(
          images: widget.turfmodel.images,
          initialIndex: index,
        ),
      ),
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  final List<dynamic> images;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: images.length,
            pageController: PageController(initialPage: initialIndex),
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(images[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              );
            },
            scrollPhysics: BouncingScrollPhysics(),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
