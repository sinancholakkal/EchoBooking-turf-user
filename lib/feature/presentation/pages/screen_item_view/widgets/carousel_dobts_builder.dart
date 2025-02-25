import 'package:echo_booking/feature/presentation/bloc/item_view/item_view_bloc.dart';
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselDobtsBuilderWidget extends StatelessWidget {
  const CarouselDobtsBuilderWidget({
    super.key,
    required this.widget,
  });

  final dynamic widget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemViewBloc, ItemViewState>(
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
              count: widget.turfmodel.images.length,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
