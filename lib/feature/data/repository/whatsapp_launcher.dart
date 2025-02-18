// watsApp launcher event
  import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

void launchWhatsApp({required String phone}) async {
    String url;
    if (Platform.isAndroid) {
      url = "whatsapp://send?phone=$phone&text=${Uri.encodeComponent("Hello")}";
    } else {
      url = "https://wa.me/$phone?text=${Uri.encodeComponent("Hello")}";
    }
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }