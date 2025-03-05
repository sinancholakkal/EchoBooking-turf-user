import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';

class StarRatingService {
Future<void> postStarRating({
  required String rating,
  required String command,
  required String ownerId,
  required String turfId,
  required String userName,
  required String bookingId
}) async {
  final snapshotRef = FirebaseFirestore.instance
      .collection('owner')
      .doc(ownerId)
      .collection('turfs')
      .doc(turfId)
      .collection('review')
      .doc(turfId);

  try {
    DocumentSnapshot snapshot = await snapshotRef.get();
    
    if (snapshot.exists && snapshot.data() != null) {
      log("Document exists and has data.");
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      int reviewCount = (data['reviewcount'] ?? 0) + 1;
      double starCount = (data['starcount'] ?? 0) + double.parse(rating); // Use double.parse

      Map<String, dynamic> newReview = {
        'name': userName,
        "star": rating,
        'command': command
      };

      await snapshotRef.update({
        'reviewcount': reviewCount,
        'starcount': starCount, // Store as double
        'reviews': FieldValue.arrayUnion([newReview]),
      });
    } else {
      log("Document does not exist or has no data. Creating new document.");
      await snapshotRef.set({
        "reviewcount": 1,
        "starcount": double.parse(rating), // Use double.parse here
        'reviews': [
          {
            "name": userName,
            "star": rating,
            "command": command
          }
        ]
      });
    }
        final snapshotRefUser = FirebaseFirestore.instance
        .collection('userApp')
        .doc(AuthService().getCurrentUser()!.uid)
        .collection('bookings')
        .doc(bookingId);

    await snapshotRefUser.update({
      "review": {
        "name": userName,
        "rating": rating,
        "command": command
      }
    });


  } catch (e) {
    log("Something went wrong while posting rating: $e");
  }
}


    // final snapshotRefUser = FirebaseFirestore.instance
    //     .collection('userApp')
    //     .doc(AuthService().getCurrentUser()!.uid)
    //     .collection('bookings')
    //     .doc(bookingId);

    // await snapshotRefUser.update({
    //   "review": {
    //     "name": userName,
    //     "rating": rating,
    //     "command": command
    //   }
    // });

  Future<Map<String,dynamic>>fetchReview({required String turfId})async{
    final snapshotRefUser = await FirebaseFirestore.instance
    .collection('userApp')
    .doc(AuthService().getCurrentUser()!.uid)
    .collection('bookings')
    .doc(turfId).get();
    Map<String,dynamic> review = await snapshotRefUser.data()?["review"];
    return review;
  }

  Future<Map<String,dynamic>>fetchAllReviews({required String ownerId,required String turfId})async{
    log("Fecthing alll reviews");
    log(ownerId);
    log(turfId);
   final snapshotRef = FirebaseFirestore.instance
    .collection('owner')
    .doc(ownerId)
    .collection('turfs')
    .doc(turfId)
    .collection('review')
    .doc(turfId);
    Map<String,dynamic> reviews = {};
    try{
      DocumentSnapshot snapshot = await snapshotRef.get();
      if(snapshot.exists){
        reviews = snapshot.data() as Map<String,dynamic>;
    
      }
        log(reviews.toString());
      
    }catch(e){
      log("Somthing wrong while fetching all reviews $e");
    }
    return reviews;
  }
}


