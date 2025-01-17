import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double screenWidth;
  String text;
  void Function()? onTap;
  CustomButton({
    super.key,
    required this.screenWidth,
    required this.text,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * .80,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 157, 198, 144)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
