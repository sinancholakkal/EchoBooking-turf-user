import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/turf_model.dart';

class SearchServices {
  Future<List<TurfModel>> searching(Map<String, String> querys) async {
    List<TurfModel> turfs = [];
    final String? searchQuery = querys["search"]?.toLowerCase();
    final String? Searchcategory = querys['category']?.toLowerCase();
    final String date = querys['date'] ?? "null";
    final String? time = querys['time'];
    final String? startprice = querys['startprice'];
    final String? endprice = querys['endprice'];
    final instance = FirebaseFirestore.instance;
    final ownerSnap = await instance.collection("owner").get();
    for (var ownerDoc in ownerSnap.docs) {
      final ownerData = ownerDoc.data();

      final turfDocs = await ownerDoc.reference.collection("turfs").get();
      if (turfDocs.docs.isNotEmpty) {
        for (var turf in turfDocs.docs) {
          bool isSearch = false;

          final turfData = turf.data();
          final String turfname = turfData['turfname'].toString().toLowerCase();
          final String category = turfData['catogery'].toString().toLowerCase();
          final String address = turfData['landmark'].toString().toLowerCase();
          log(address);
          if (searchQuery != null && turfname.contains(searchQuery) ||
              searchQuery == category || address.contains(searchQuery!)) {
            isSearch = true;
          }
          if (isSearch == true && startprice != null && endprice != null) {
            double start = double.parse(startprice);
            double end = double.parse(endprice);
            int price = int.parse(turfData["price"]);
            if (!(start <= price && price <= end)) {
              isSearch = false;
            }
          }
          final timeSlotesColle = ownerDoc.reference
              .collection('turfs')
              .doc(turf.id)
              .collection('timeSlotes');
          if (isSearch == true && date != "null") {
         
            int flag = 0;
            final timeSlotes = await timeSlotesColle.get();
            for (var timeSlote in timeSlotes.docs) {
              
              if (date == timeSlote.id) {
                
                // flag =1;
                // break;
                if (time != "null") {
                  log("time entried");
                  Map<String, dynamic> timeData = timeSlote.data();
                  if (timeData.containsKey("time_slot") &&
                      timeData["time_slot"] is List) {
                    List<dynamic> timeSlotList = timeData["time_slot"];

                    for (var slot in timeSlotList) {
                      if (slot is Map<String, dynamic>) {
                       String pTime = time!.replaceAll(RegExp(r'\s+'), ' '); 
                       String dTime = slot['time'].toString().replaceAll(RegExp(r'\s+'), ' ');
                        if(dTime.contains(pTime)){
                          log("contaised");
                          flag =1;
                          break;
                        }
                      }
                    }
                    if(flag==1)break;
                  }
                } else {
                  flag = 1;
                  break;
                }
              }
            }
            if (flag != 1) isSearch = false;
          }
          // if(isSearch==true && time !="null"){
          //   final timeSlotes = await timeSlotesColle.get();
          //   for(var timeSlote in timeSlotes.docs){
          //     String dateKey = timeSlote.id;
          //     Map<String, dynamic> timeData = timeSlote.data();
          //     for(var timeSlote in timeDataList){
          //       log(timeSlote.toString());
          //     }
          //   }
          // }
          if (isSearch && turfData["reviewStatus"] == "true") {
            final turfModel = TurfModel(
              latitude: turfData['latitude'],
              longitude: turfData['longitude'],
              ownerId: ownerData['uid'],
              turfId: turfData['turfid'],
              ownerName: ownerData['name'],
              ownerEmail: ownerData['email'],
              turfName: turfData['turfname'],
              phone: turfData['phone'],
              email: turfData['email'],
              price: turfData['price'],
              state: turfData['state'],
              country: turfData['country'],
              catogery: turfData['catogery'],
              includes: turfData['includes'],
              landmark: turfData['landmark'],
              reviewStatus: turfData['reviewStatus'],
              images: turfData["images"],
            );
            turfs.add(turfModel);
          }
        }
      }
    }
    return turfs;
  }
}
