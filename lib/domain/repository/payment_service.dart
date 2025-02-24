import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/turf_model.dart';

class PaymentService {
  Future<void> disableTimeSlot({
    required TurfModel turfmodel,
    required String datekey,
    required String bookedTime,
  }) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection("owner")
          .doc(turfmodel.ownerId)
          .collection("turfs")
          .doc(turfmodel.turfId)
          .collection("timeSlotes")
          .doc(datekey);

      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        log("Document does not exist.");
        return;
      }

      Map<String, dynamic>? timeSlotData = snapshot.data();

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
          time["isAvailable"] = false; // Mark as booked
          updated = true;
          break;
        }
      }

      // Save only if there's an update
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
}
