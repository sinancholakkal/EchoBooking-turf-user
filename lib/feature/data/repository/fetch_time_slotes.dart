import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/turf_model.dart';

Future<Map<String, List<Map<String, dynamic>>>> fetchingTimeSlots({required TurfModel turfmodel}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("owner")
        .doc(turfmodel.ownerId)
        .collection("turfs")
        .doc(turfmodel.turfId)
        .collection("timeSlotes")
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> timeSlotes =
        snapshot.docs;
    Map<String, List<Map<String, dynamic>>> timeSlotsMap = {};
    for (var timeSlot in timeSlotes) {
      String dateKey = timeSlot.id;
      Map<String, dynamic> timeData = timeSlot.data();

      if (!timeSlotsMap.containsKey(dateKey)) {
        timeSlotsMap[dateKey] = [];
      }

      if (timeData.containsKey("time_slot") && timeData["time_slot"] is List) {
        List<dynamic> timeSlotList = timeData["time_slot"];

        for (var slot in timeSlotList) {
          if (slot is Map<String, dynamic>) {
            timeSlotsMap[dateKey]?.add(slot);
          }
        }
      } else {
        timeSlotsMap[dateKey]?.add(timeData);
      }
    }
    return timeSlotsMap;
  }
