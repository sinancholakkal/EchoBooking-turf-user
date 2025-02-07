import 'dart:developer';

import 'package:echo_booking/feature/presentation/widgets/showDiolog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  String? uidOfUser;

  User? getCurrentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      log("succsess=============");
      return await _auth.signInWithCredential(cred);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //cheking login status
  bool checkLoginStatus() {
    return (_auth.currentUser == null) ? false : true;
  }

  //create user (sign up)
  Future<User?> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    uidOfUser = cred.user!.uid;
    return cred.user;
  }

  //create user (Sign In)
  Future<User?> signInUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  //signOut
  Future<void> signOut() async {
    // try {
    await _auth.signOut();
    // } catch (e) {
    //   log("Somthing went wrong while LognOut");
    // }
  }
  //forgot---
  Future<void>forgotPassword(String email)async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
