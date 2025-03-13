import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/feature/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyContentSection extends StatelessWidget {
  const PrivacyPolicyContentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Privacy Policy",
            size: 35,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            text:
                "Welcome to Echo Turf Booking. Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our Turf Booking Application.",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          //1. Information We Collect---------
          TextWidget(
            text: "1. Information We Collect",
            size: 25,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            text:
                "When you use our app, we may collect the following types of information:",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          TextWidget(
            text: "a) Personal Information",
            size: 18,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            text: " - Name",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          TextWidget(
            text: " - Phone number (if provided)",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          TextWidget(
            text: " - Email address (for authentication)",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          //2. Data Sharing & Security--------------
          TextWidget(
            text: "2. Data Sharing & Security",
            size: 25,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            text: "🔹 We do not sell your personal data to third parties.",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          TextWidget(
            text:
                "🔹 Your data is stored securely using Firebase with encryption and access controls.",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          //3.Changes to this Policy---------
          TextWidget(
            text: "3. Changes to this Policy",
            size: 25,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            text:
                "We may update this Privacy Policy from time to time. Any changes will be reflected in the app, and we encourage you to review this policy periodically.",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          //4.  Contact Us
          TextWidget(
            text: "4. Contact Us",
            size: 25,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            text:
                "If you have any questions or concerns, please contact us at:",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          TextWidget(
            text: "📩 sinanzzsinu70@gmail.com",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          TextWidget(
            text: "📞 +917025653318",
            textOverflow: TextOverflow.visible,
            maxLine: 10,
            size: 16,
            color: kGrey,
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
