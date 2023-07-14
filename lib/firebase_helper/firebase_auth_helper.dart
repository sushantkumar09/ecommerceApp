import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/models/user_model.dart';
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
     String name, String email, String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(name: name, id: userCredential.user!.uid, email: email,
      image: null);
      _firestore.collection('users').doc(userModel.id).set(userModel.toMap());
      Navigator.of(context,rootNavigator: true).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }
  void signOut()async{
    await _auth.signOut();
  }

  Future<bool> changePassword(
     String password, BuildContext context) async {
    try {
      showLoaderDialog(context);
      _auth.currentUser!.updatePassword(password);
      // UserCredential userCredential =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // UserModel userModel = UserModel(name: name, id: userCredential.user!.uid, email: email,
      //     image: null);
      // _firestore.collection('users').doc(userModel.id).set(userModel.toMap());
      // Navigator.of(context,rootNavigator: true).pop();
      Navigator.of(context,rootNavigator: true).pop();
      showMessage("Password changed");
      Navigator.of(context).pop();

      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context,rootNavigator: true).pop();
      showMessage(error.code.toString());
      return false;
    }
  }



}
