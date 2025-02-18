
import 'package:echo_booking/feature/presentation/pages/screen_item_view/screen_item_view.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncludesBuilderWidget extends StatelessWidget {
  const IncludesBuilderWidget({
    super.key,
    required this.widget,
  });

  final ScreenItemView widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.turfmodel.includes
            .split(",")
            .toList()
            .length,
        itemBuilder: (context, index) {
          final List<String> include = widget
              .turfmodel.includes
              .split(",")
              .toList();
          return Padding(
            padding: const EdgeInsets.only(left: 25),
            child: TextWidget(
              text: "- ${include[index]}",
              color: Colors.white70,
              size: 16,
            ),
          );
        },
      ),
    );
  }
}

