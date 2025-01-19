import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: screenWidth *0.06,
                  child: Image.asset("asset/icons/football.png"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(popularText,style: TextStyle(
                    color: kWhite,
                    fontSize: 20
                  ),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
