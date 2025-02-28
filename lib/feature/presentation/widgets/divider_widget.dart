import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets
          .symmetric(
          horizontal: 10),
      child: Divider(
        color: kGrey,
        height: 0.1,
        thickness: 0.3,
      ),
    );
  }
}
