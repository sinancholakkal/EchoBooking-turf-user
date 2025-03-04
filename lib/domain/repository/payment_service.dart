import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentService {
  Future<void> disableTimeSlot({
    required TurfModel turfmodel,
    required String datekey,
    required String bookedTime,
  }) async {
    log("time slot disable called");
    log(turfmodel.ownerId);
    log(turfmodel.turfId);
    log("eeeeeeeeeeeeeeeee");
    log(datekey);
    try {
      final docRef = FirebaseFirestore.instance
          .collection("owner")
          .doc(turfmodel.ownerId)
          .collection("turfs")
          .doc(turfmodel.turfId)
          .collection("timeSlotes")
          .doc(datekey);

      final snapshot = await docRef.get();

      // if (!snapshot.exists) {
      //   log("Document does not exist.");
      //   return;
      // }

      Map<String, dynamic>? timeSlotData = snapshot.data();
      log(timeSlotData.toString());
      log("=================");

      if (timeSlotData == null || !timeSlotData.containsKey("time_slot")) {
        log("No valid time_slot found.");
        return;
      }

      List<dynamic>? timeSlots = timeSlotData["time_slot"];

      if (timeSlots == null || timeSlots.isEmpty) {
        log("time_slot is empty or null.");
        return;
      }

      // Update the booked time slot
      bool updated = false;
      for (var time in timeSlots) {
        if (time is Map<String, dynamic> && time["time"] == bookedTime) {
          log("Time availability updated.");
          time["isAvailable"] = false;
          log("Disabled----");
          updated = true;
          break;
        }
      }
      if (updated) {
        await docRef.update({"time_slot": timeSlots});
        log("Time slot successfully updated.");
      } else {
        log("No matching time slot found.");
      }
    } catch (e) {
      log("Something went wrong while updating time availability: $e");
    }
  }

  Future<void> addBookingTurf({
    required TurfModel turfModel,
    required String date,
    required String time,
    required String paymentId,
    required String userName,
    required String price,
    required String bookingTurfId
  }) async {
    log("Add bookings called");
    final User? user = AuthService().getCurrentUser();
    await FirebaseFirestore.instance
        .collection("userApp")
        .doc(user!.uid)
        .collection("bookings")
        .doc(bookingTurfId)
        .set({
          "bookingid":bookingTurfId,
      "turfname": turfModel.turfName,
      "phone": turfModel.phone,
      "email": turfModel.email,
      "price": price,
      "state": turfModel.state,
      "country": turfModel.country,
      "latitude": turfModel.latitude,
      "longitude": turfModel.longitude,
      "catogery": turfModel.catogery,
      "includes": turfModel.includes,
      "landmark": turfModel.landmark,
      "images": turfModel.images,
      "turfid": turfModel.turfId,
      "reviewStatus": turfModel.reviewStatus,
      'bookingtime': time,
      'slotdate': date,
      'paymentid': paymentId,
      'ownerid': turfModel.ownerId,
      'username': userName,
      'bookingdate':
          "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}",
    });
    log("Booking added===================");
  }

  Future<void> updateInOwner({
    required TurfModel turfModel,
    required String date,
    required String time,
    required String paymentId,
    required UserModel userModel,
    required String price,
    required String bookingTurfId
  }) async {
    log("owner update called");
    await FirebaseFirestore.instance
        .collection("owner")
        .doc(turfModel.ownerId)
        .collection("bookings")
        .doc(bookingTurfId)
        .set({
          "bookingId":bookingTurfId,
      "turfname": turfModel.turfName,
      "price": price,
      "catogery": turfModel.catogery,
      "turfid": turfModel.turfId,
      "reviewStatus": turfModel.reviewStatus,
      'bookingtime': time,
      'slotdate': date,
      'paymentid': paymentId,
      'username': userModel.name,
      'userphone': userModel.phone,
      'bookingdate':
          "${DateTime.now().day.toString().padLeft(2, '0')}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().year}",
    });
    log("Owner updated====");
  }
}
