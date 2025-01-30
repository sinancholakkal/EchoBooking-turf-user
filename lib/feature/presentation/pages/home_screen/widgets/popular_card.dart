
import 'dart:ui';

import 'package:echo_booking/core/constent/size/size.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  const PopularCard({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: screenWidth * 0.78,
      width: screenWidth * 0.68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cardRadius),
        color: cardBgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        //sspacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(cardRadius),
            child: Image.network(
              fit: BoxFit.cover,
              "https://imgs.search.brave.com/d9zLy3LpeCN68slQIY7sAcl_k-NmM0I3nFFBuaVGlOE/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA4LzUzLzU0LzEy/LzM2MF9GXzg1MzU0/MTI0MF85MHFuZVlE/YjNMSnhNRHczMzJr/TVJqcExuU1doeVRH/Qy5qcGc",
            ),
          ),
          Text(
            "Mannarkkad Turf",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Row(
            // mainAxisSize: MainAxisSize.max,

            children: [
              Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              SizedBox(
                width: 4,
              ),
              Flexible(
                child: Text(
                  "parampulli,palakkad, dsjhdksjhljkaslkj",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kGrey,
                  ),
                ),
              ),
            ],
          ),
          height10,
          //Book button-----------------------
          Align(
            alignment: Alignment.bottomRight,
            child: CustomButton(
              onTap: () {},
              text: "Book",
              width: 80,
              height: 30,
              color: buttonColor,
              radius: 7,
              textStyle: TextStyle(color: kWhite, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
