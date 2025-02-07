import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/user_model.dart';
import 'package:echo_booking/domain/repository/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  Future<void> userStore(UserModel user) async {
    print("===================================storeddetails called");
    FirebaseFirestore.instance.collection("userApp").doc(user.uid).set({
      "uid": user.uid,
      "name": user.name,
      "phone": user.phone,
      "address": user.address,
      "gender": user.gender
    });
  }

  Future<UserModel> userDataFetching() async {
    log("Fetch method called");
    AuthService _auth = AuthService();
    String? uid = _auth.getCurrentUser()!.uid;
    log(uid.toString());
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("userApp").doc(uid).get();

      final data = doc.data() as Map<String, dynamic>;
      log(doc.data().toString());
      UserModel userModel = UserModel(
        name: data["name"] ??"Unknown",
        phone: data["phone"] ?? "No phone",
        address: data["address"] ?? "No address",
        uid: data["uid"] ?? uid,
        gender: data["gender"] ?? "Unknown",
      );
      return userModel;
  }
  Future<void>userDataUpdate(UserModel user)async{
    final CollectionReference docs = FirebaseFirestore.instance.collection('userApp');
    Map<String,dynamic> data = {
      "name" : user.name,
      "phone":user.phone,
      "address":user.address,
      "gender":user.gender
    };
    docs.doc(user.uid).update(data);
  }
}
