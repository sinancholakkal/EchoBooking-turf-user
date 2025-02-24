  import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> flutterToast({required String msg,Color? color = Colors.transparent}) {

    return Fluttertoast.showToast(
      
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: kWhite,
      fontSize: 18.0,
    );
  }