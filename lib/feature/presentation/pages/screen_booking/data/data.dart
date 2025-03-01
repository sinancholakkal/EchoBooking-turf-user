import 'dart:math';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/widgets/flutter_toast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ScreenBookingData {
  String? paymentId;
  static List<Map<String, String>> getDetailsScreenBooking(
      {required TurfModel turfModel,
      required num taxesAndFee,
      required String time}) {
    return [
      {"Time": time},
      {"Book amount": "₹${turfModel.price}"},
      {"Taxes & fees": taxesAndFee.toString()},
      {
        "Total Price": "${taxesAndFee + int.parse(turfModel.price)}",
      }
    ];
  }

  static void openCheckout(amount, Razorpay razorpay) async {
    var options = {
      "key": 'rzp_test_4MBYamMKeUifHI',
      'amount': amount,
      'name': 'Echo Turf Booking Application',
      'prefill': {'contact': '1234567890', 'email': 'test@gmail.com'},
      "method": {"upi": true, "card": true, "netbanking": true, "wallet": true}
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print("Error while doing payment $e");
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    flutterToast(msg: "Payment Fail ${response.message!}", color: kGrey);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    flutterToast(
        msg: "Payment Successfull ${response.walletName!}", color: kGrey);
  }

  static String getRandomId() {
    final Random random = Random();
    return "booking_${random.nextInt(10000000)}";
  }
}
