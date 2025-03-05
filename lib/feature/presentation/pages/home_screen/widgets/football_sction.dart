import 'dart:developer';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/tabs/home_tab.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_heading.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/football_item_card_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FootballSection extends StatefulWidget {
  List<TurfModel> footballTurfs;
  int max;
  bool visibilityMore;
  double screenWidth;
  FootballSection({
    super.key,
    required this.footballTurfs,
    required this.max,
    required this.visibilityMore,
    required this.screenWidth,
  });

  @override
  State<FootballSection> createState() => _FootballSextionState();
}

class _FootballSextionState extends State<FootballSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CardHead(
              text: footballText,
            ),
          ),
          Wrap(
            children: List.generate(
              //max<length?max:length,
              widget.footballTurfs.length < widget.max
                  ? widget.footballTurfs.length + 1
                  : widget.max,
              (index) {
                log(index.toString());
                if (index == widget.max - 1) {
                  log("show more===================");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (widget.max + 4 >
                                  widget.footballTurfs.length) {
                                widget.max = widget.footballTurfs.length + 1;
                                widget.visibilityMore = false;
                              } else {
                                widget.max += 4;
                              }
                            });
                          },
                          child: Visibility(
                            visible: widget.visibilityMore,
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
                  return FootballItemCardWidget(
                      turfModel: widget.footballTurfs[index],
                      screenWidth: widget.screenWidth,
                      index: index);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}