import 'package:echo_booking/core/constent/image/image_constand.dart';
import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:flutter/material.dart';

class HeadingsAndImgWidget extends StatelessWidget {
  const HeadingsAndImgWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     child: Column(
       children: [
          SizedBox(
       height: 60,
     ),
     Padding(
       padding: EdgeInsets.only(left: 26),
       child: HeadingText(
         text: appTitle,
       ),
     ),
     Image(
       height: 340,
       width: 420,
       fit: BoxFit.cover,
       image: AssetImage(loginPlayer),
     ),
     SizedBox(
       height: 10,
     ),
     Center(
         child: HeadingText(
       text: "Hello, Welcome !",
     )),
     Center(
         child: Text(
       "Welcome to EchoBooking.In Top\nplatform to coders",
       textAlign: TextAlign.center,
       style: TextStyle(color: kWhite),
     )),
     SizedBox(
       height: 40,
     ),
       ],
     ),
    );
  }
}
