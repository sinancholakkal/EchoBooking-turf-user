
import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: kWhite,
          //border: UnderlineInputBorder(),

          //label: Text(textUserName),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(26))),
    );
  }
}
