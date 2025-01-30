import 'dart:developer';

import 'package:echo_booking/feature/presentation/widgets/showDiolog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  String? uidOfUser;

  //create user (sign up)
  Future<User?> createUserWithEmailAndPassword(
      String email, String password,BuildContext context) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          uidOfUser = cred.user!.uid;
      return cred.user;

    } on FirebaseAuthException catch (e) {
      log("Somthing wrong while Sign Up ${e.code}");
      if(e.code=="email-already-in-use"){
        showDiolog(
          context: context,
          title: "Email Already in Use",
          content: "This email is already registered. Please use a different email or sign in.",
        );
      }
    }
    return null;
  }

  //create user (Sign In)
  Future<User?> signInUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log(" ${e.code}");
      if (e.code == "invalid-credential") {
        showDiolog(
          context: context,
          title: "Incorrect Password",
          content: "The password you entered is incorrect.\nPlease try again.",
        );
      }
    }
    return null;
  }

  //signOut
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Somthing went wrong while LognOut");
    }
  }
}
