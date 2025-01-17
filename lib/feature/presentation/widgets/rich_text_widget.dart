import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  void Function()? onTap;
  String text;
  String eventText;
   RichTextWidget({
    super.key,
    this.onTap,
    required this.text,
    required this.eventText
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(text: text, children: [
      TextSpan(
          style: TextStyle(fontWeight: FontWeight.bold),
          text: eventText,
          recognizer: TapGestureRecognizer()..onTap = onTap)
    ]));
  }
}
