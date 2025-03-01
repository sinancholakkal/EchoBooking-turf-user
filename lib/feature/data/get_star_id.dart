  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:flutter/cupertino.dart';

Future<bool> getStarIds( String turfId) async {
    final resu = await FirebaseFirestore.instance
        .collection("userApp")
        .doc(AuthService().getCurrentUser()!.uid)
        .collection("star")
        .get();
    final docs = resu.docs;
    return docs.any((doc) => doc.id == turfId);
  }