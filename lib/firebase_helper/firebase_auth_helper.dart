import 'package:ecommerce/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// class FirebaseAuthHelper {
//   static FirebaseAuthHelper instance = FirebaseAuthHelper();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Stream<User?> get getAuthChange => _auth.authStateChanges();
//
//   Future<bool> login(
//       String email, String password, BuildContext context) async {
//     try {
//       showLoaderDialog(context);
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       Navigator.of(context,rootNavigator :true).pop();
//
//       return true;
//     } on FirebaseException catch (e) {
//       Navigator.of(context,rootNavigator: true).pop();
//       showMessage(e.code.toString());
//
//       return false;
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:youtube_ecommerce/constants/constants.dart';
// import 'package:youtube_ecommerce/models/user_model/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
  Future<bool> signUp(
      String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

}
