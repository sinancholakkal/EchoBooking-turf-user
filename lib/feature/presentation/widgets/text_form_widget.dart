import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int maxLine;
  TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    this.maxLine =1
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: kWhite,
        //border: UnderlineInputBorder(),

        //label: Text(textUserName),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),
    );
  }
}
