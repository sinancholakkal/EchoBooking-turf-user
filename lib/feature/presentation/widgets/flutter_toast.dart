  import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> flutterToast({required String msg}) {

    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.transparent,
      textColor: kWhite,
      fontSize: 20.0,
    );
  }