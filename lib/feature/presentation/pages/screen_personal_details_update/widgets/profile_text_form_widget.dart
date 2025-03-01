import 'package:echo_booking/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ProfileTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  const ProfileTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validation
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: validation,
        controller: controller,

        style: TextStyle(
          color: kWhite
        ),
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}