import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:flutter/material.dart';

class TurfService {
  //Fetching turfs for review------------------
  Future<List<List<TurfModel>>> fetchAllTurfs() async {
    log("Fetch all event called========");
    final instance = FirebaseFirestore.instance;
    List<List<TurfModel>> turfs = [
      [],[]
    ];

    final ownerSnap = await instance.collection("owner").get();

    for (var ownerDoc in ownerSnap.docs) {
      log(ownerDoc.id);
      final ownerData = ownerDoc.data();
      final turfDocs = await ownerDoc.reference.collection("turfs").get();

      if (turfDocs.docs.isNotEmpty) {
        for (var turf in turfDocs.docs) {
          final turfData = turf.data();
          if (turfData["reviewStatus"] == false || turfData["reviewStatus"]==true) {
            log(turfData.toString());

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
                images: turfData["images"]);
              if(turfModel.catogery=="Football"){
                turfs[0].add(turfModel);
              }else{
                turfs[1].add(turfModel);
              }
              turfModel.ownerId;
          }
        }
      }
    }
    return turfs;
  }

  // Future<void> upproveTurfEvent(String ownerId, String turfId) async {
  //   final instance = FirebaseFirestore.instance;
  //   final owner = instance.collection("owner").doc(ownerId);
  //   await owner.collection("turfs").doc(turfId).update({
  //     "reviewStatus": true,
  //   });
  // }
}
