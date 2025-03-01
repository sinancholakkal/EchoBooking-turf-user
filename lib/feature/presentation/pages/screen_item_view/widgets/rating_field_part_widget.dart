import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/feature/presentation/bloc/star_rating_bloc/star_rating_bloc.dart' as bloc;
import 'package:echo_booking/feature/presentation/pages/screen_item_view/widgets/view_all_button.dart';
import 'package:echo_booking/feature/presentation/pages/screen_view_all_reviews/screen_view_all_reviews.dart';
import 'package:echo_booking/feature/presentation/widgets/animated_star_rating.dart';
import 'package:echo_booking/feature/presentation/widgets/circular_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/divider_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/rating_list_tile.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
class RatingFieldPartWidget extends StatelessWidget {
  const RatingFieldPartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          height20,
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                text: "Rating & Reviews",
              ),
            ),
          ),
          bloc.BlocBuilder<bloc.StarRatingBloc,
              bloc.StarRatingState>(
            builder: (context, state) {
              if (state
                  is bloc.FetchAllReviewsLoadingState) {
                return CircularWidget();
              } else if (state
                  is bloc.FetchAllReviewsLoadedState) {
                if (state.reviews.isEmpty) {
                  return TextWidget(
                    text: "Not posted",
                  );
                } else {
                  double r = (double.parse(state
                          .reviews['rating']) /
                      int.parse(state.reviews[
                          'reviewcount']));
                  List<dynamic> reviews =
                      state.reviews['reviews'];
                  return SizedBox(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets
                                  .only(left: 10),
                          child: Align(
                            alignment:
                                Alignment.topLeft,
                            child:
                                AnimatedStarRatingWidget(
                              onChanged: (val) {},
                              initial: r,
                              readOnly: true,
                            ),
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics:
                              NeverScrollableScrollPhysics(),
                          itemCount:
                              (reviews.length > 4)
                                  ? 5
                                  : reviews
                                      .length,
                          separatorBuilder:
                              (context, index) {
                            return DividerWidget();
                          },
                          itemBuilder:
                              (context, index) {
                            if (index == 4) {
                              return //View All feedback---------------
                                  ReviewAllButtonWidget(
                                onTap: () => Get.to(
                                    () => ScreenViewAllReviews(
                                        reviews:
                                            reviews),
                                    transition:
                                        Transition
                                            .cupertino),
                              );
                            } else {
                              //List tile of display the review----
                              Map<String, dynamic>
                                  data =
                                  reviews[index];
                              return RatingListTileWidget(
                                  data: data);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
