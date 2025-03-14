import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/widgets/card_turf_widget.dart';
import 'package:intl/intl.dart';

Future<Map<String, List<Map<String, dynamic>>>> fetchingTimeSlots(
    {required TurfModel turfmodel, required ActionTypeFrom type}) async {
      log("Fetching time slotes,.....");
  final snapshotRef = FirebaseFirestore.instance
      .collection(ActionTypeFrom.noStar == type ? "owner" : "userApp")
      .doc(turfmodel.ownerId)
      .collection(ActionTypeFrom.noStar == type ? "turfs" : "star")
      .doc(turfmodel.turfId)
      .collection("timeSlotes");
  QuerySnapshot<Map<String, dynamic>> snapshot = await snapshotRef.get();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> timeSlotes = snapshot.docs;
  Map<String, List<Map<String, dynamic>>> timeSlotsMap = {};
  for (var timeSlot in timeSlotes) {
    String dateKey = timeSlot.id;

    Map<String, dynamic> timeData = timeSlot.data();
    int date = int.parse(dateKey.split("-")[2]);
    log(date.toString());
    int currentDate = DateTime.now().day;
    int month = int.parse(dateKey.split("-")[1]);
      int todayMonth = DateTime.now().month;
    try{
      if (date >= currentDate ) {
      if(month>=todayMonth){
        if (!timeSlotsMap.containsKey(dateKey)) {
        timeSlotsMap[dateKey] = [];
      }

      if (timeData.containsKey("time_slot") && timeData["time_slot"] is List) {
        List<dynamic> timeSlotList = timeData["time_slot"];

        for (var slot in timeSlotList) {
          if (slot is Map<String, dynamic>) {
            //log(slot['time']);
            String timeString = slot['time'].toString().split(" ")[2];
            timeString = timeString.replaceAll('\u202F', ' ').replaceAll('\u00A0', ' ').trim();
            String dateAndTime = "$dateKey $timeString";
                log("$dateAndTime ===========");
           
            DateTime givenTime = DateFormat("yyyy-MM-dd hh:mm a").parse(dateAndTime);
            log(givenTime.toString());
            DateTime currentTime = DateTime.now();
            if (givenTime.isBefore(currentTime)) {
               log(dateAndTime);
               slot = {
                'time':slot['time'],
                'isAvailable':false,
               };
               
            }
            timeSlotsMap[dateKey]?.add(slot);
          }
        }
      } else {
        timeSlotsMap[dateKey]?.add(timeData);
      }
      }else{
        await snapshotRef.doc(dateKey).delete();
      log("$date deleted----------");
      }
    } else {
      await snapshotRef.doc(dateKey).delete();
      log("$date deleted----------");
    }
    }catch(e){
      log("Somthing issue while fetching time $e");
    }
  }
  return timeSlotsMap;
}
