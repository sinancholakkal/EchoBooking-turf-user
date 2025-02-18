import 'dart:io';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class TurfViewServises {
  Future<void> openInGoogleMap(String current) async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$current";
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      log("cannot launch" as num);
    }
  }

  Future<void> callLauncher({required String phone}) async {
    final Uri launcher = Uri(scheme: 'tel', path: phone);
    await launchUrl(launcher);
  }

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
}
