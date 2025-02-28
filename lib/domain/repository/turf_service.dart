import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/booking_turf_model.dart';
import 'package:echo_booking/domain/model/turf_model.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:echo_booking/domain/repository/user_service.dart';
import 'package:flutter/material.dart';

class TurfService {
  //Fetching turfs for review------------------
  Future<List<List<TurfModel>>> fetchAllTurfs() async {
    log("Fetch all event called========");
    final instance = FirebaseFirestore.instance;
    List<List<TurfModel>> turfs = [[], []];

    final ownerSnap = await instance.collection("owner").get();

    for (var ownerDoc in ownerSnap.docs) {
      log(ownerDoc.id);
      final ownerData = ownerDoc.data();
      final turfDocs = await ownerDoc.reference.collection("turfs").get();

      if (turfDocs.docs.isNotEmpty) {
        for (var turf in turfDocs.docs) {
          final turfData = turf.data();
          if (turfData["reviewStatus"] == "true") {
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
            if (turfModel.catogery == "Football") {
              turfs[0].add(turfModel);
            } else {
              turfs[1].add(turfModel);
            }
            turfModel.ownerId;
          }
        }
      }
    }
    return turfs;
  }

  Future<List<TurfModel>> fetchTurfStars() async {
    log("Fetch all event called========");
    final instance = FirebaseFirestore.instance;
    List<TurfModel> turfs = [];

    final userDataRef =
        instance.collection("userApp").doc(AuthService().getCurrentUser()!.uid);

    final userV = await userDataRef.get();
    final userData = userV.data();
    final userStars = await userDataRef.collection('star').get();
    for (var star in userStars.docs) {
      final turfData = star.data();
      final turfModel = TurfModel(
          latitude: turfData['latitude'],
          longitude: turfData['longitude'],
          ownerId: userData!['uid'],
          turfId: turfData['turfid'],
          ownerName: userData['name'],
          ownerEmail: userData['email'] ?? "Unknown",
          turfName: turfData['turfname'],
          phone: turfData['phone'],
          email: turfData['email'] ?? "Unknown",
          price: turfData['price'],
          state: turfData['state'],
          country: turfData['country'],
          catogery: turfData['catogery'],
          includes: turfData['includes'],
          landmark: turfData['landmark'],
          reviewStatus: turfData['reviewStatus'],
          images: turfData["images"]);
      turfs.add(turfModel);
    }

    return turfs;
  }

  Future<void> starAddTurf(TurfModel turfModel,
      Map<String, List<Map<String, dynamic>>> timeSlots) async {
    log(timeSlots.toString());
    await FirebaseFirestore.instance
        .collection("userApp")
        .doc(AuthService().getCurrentUser()!.uid)
        .collection("star")
        .doc(turfModel.turfId)
        .set({
      "turfname": turfModel.turfName,
      "phone": turfModel.phone,
      "email": turfModel.email,
      "price": turfModel.price,
      "state": turfModel.state,
      "country": turfModel.country,
      "latitude": turfModel.latitude,
      "longitude": turfModel.longitude,
      "catogery": turfModel.catogery,
      "includes": turfModel.includes,
      "landmark": turfModel.landmark,
      "images": turfModel.images,
      "turfid": turfModel.turfId,
      "reviewStatus": turfModel.reviewStatus
    });
    timeSlots.forEach((key, value) async {
      await FirebaseFirestore.instance
          .collection("userApp")
          .doc(AuthService().getCurrentUser()!.uid)
          .collection("star")
          .doc(turfModel.turfId)
          .collection("timeSlotes")
          .doc(key)
          .set({"time_slot": value});
    });
  }

  Future<void> deleteTurfFromStar(String turfId) async {
    final firestore = FirebaseFirestore.instance;
    final ownerDoc = firestore
        .collection("userApp")
        .doc(AuthService().getCurrentUser()!.uid);
    final turfDoc = ownerDoc.collection("star").doc(turfId);

    final dateDocs = await turfDoc.collection("timeSlotes").get();
    for (var doc in dateDocs.docs) {
      await doc.reference.delete();
    }
    await turfDoc.delete();
  }

  Future<List<BookingTurfmodel>> fetchBookings() async {
    List<BookingTurfmodel> turfs = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("userApp")
        .doc(AuthService().getCurrentUser()!.uid)
        .collection("bookings")
        .get();

    for (var turfData in snapshot.docs) {
      final turf = turfData.data();
      String dateAndTime =
          "${turf['bookingdate']} ${turf['bookingtime'].toString().split(" ")[2]}";
      DateTime givenTime = DateTime.parse(dateAndTime);
      DateTime currentTime = DateTime.now();
      String status = "";
      if (givenTime.isAfter(currentTime)) {
        status = "Live";
      } else {
        status = "Closed";
      }
      log(currentTime.toString());
      log(givenTime.toString());
      log(status);
      final bookingTurfModel = BookingTurfmodel(

        ownerId: turf['ownerid'],
        userName: turf['username'],
        price: turf['price'],
        review: turf['review'],
          bookingDate: turf['bookingdate'],
          bookingTime: turf['bookingtime'],
          catogery: turf['catogery'],
          images: turf['images'],
          includes: turf['includes'],
          latitude: turf['latitude'],
          longitude: turf['longitude'],
          turfName: turf['turfname'],
          turfId: turf['turfid'],
          landmark: turf['landmark'],
          status: status);

      (status=='Live')?turfs.insert(0, bookingTurfModel):turfs.add(bookingTurfModel);
    }
    return turfs;
  }
}
