import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';

class CardHead extends StatelessWidget {
  String text;
   CardHead({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: catIconSize,
            child: Image.asset("asset/icons/football.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(
                  color: kWhite,
                  fontSize: catNameSize,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}