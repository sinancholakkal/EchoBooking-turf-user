import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';

class StarRatingService {
  Future<void>postStarRating({required String rating,required String command,required String ownerId,required String turfId,required String userName})async{
    final snapshotRef = FirebaseFirestore.instance
    .collection('owner')
    .doc(ownerId)
    .collection('turfs')
    .doc(turfId)
    .collection('review')
    .doc(turfId);
    try{
      DocumentSnapshot snapshot = await snapshotRef.get();
      if(snapshot.exists){
        Map<String,dynamic>data = snapshot.data() as Map<String,dynamic>;
        int reviewCount = int.parse(data['reviewcount']??0)+1;
        double starCount = double.parse(data['starcount']??0);
        List<dynamic>reviews = List.from(data['reviews']??[]);

        Map<String,dynamic>newReview = {
          'name':userName,
          "star":rating,
          'command':command
        };
        snapshotRef.update({
          'reviewcount':reviewCount.toString(),
          'starcount':(double.parse(rating)+starCount).toString(),
          'reviews': FieldValue.arrayUnion([newReview]),
        });
      }else{
        snapshotRef.set({
          "reviewcount":"1",
          "rating":rating,
          'reviews':[
            {
              "name":userName,
              "star":rating,
              "command":command
            }
          ]
        });
      }
      final snapshotRefUser =  FirebaseFirestore.instance
    .collection('userApp')
    .doc(AuthService().getCurrentUser()!.uid)
    .collection('bookings')
    .doc(turfId);
    await snapshotRefUser.update({
      "review":{
         "name":userName,
          "rating":rating,
          "command":command
      } 
    });
    
    }catch(e){
      log("Somthing wrong while post rating $e");
    }
    
  }
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


