import 'package:url_launcher/url_launcher.dart';

Future<void>callLauncher({required String phone})async{
   final Uri launcher = Uri(scheme: 'tel', path: phone);
            await launchUrl(launcher);
}