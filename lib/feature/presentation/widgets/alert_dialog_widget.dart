import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final void Function() cancelOnTap;
  final void Function() okOnTap;
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.cancelOnTap,
    required this.okOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: cardBgColor,
      title: TextWidget(
        text: title,
        color: kWhite,
      ),
      content: TextWidget(
        text: content,
        color: Colors.grey,
        maxLine: 2,
      ),
      actions: [
        TextButton(onPressed: cancelOnTap, child: Text("Cancel")),
        TextButton(onPressed: okOnTap, child: Text("Ok"))
      ],
    );
  }
}