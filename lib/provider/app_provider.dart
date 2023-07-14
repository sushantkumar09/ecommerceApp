import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/firebase_helper/firebase_storage_helper.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  //for cart
  final List<ProductModel> _cartProductList = [];
  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  //for favourite

  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  // user information

  // void getUserinfoFirebase() async {
  //  _userModel =  await FirebaseFirestoreHelper.instance.getUserInformation();
  //  notifyListeners();
  //
  // }
  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    showLoaderDialog(context);
    if (file == null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(userModel.toMap());
      notifyListeners();
      Navigator.of(context).pop();
    } else {
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toMap());
      Navigator.of(context).pop();
      notifyListeners();
    }

  }
}

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserInformation() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(uid).get();

      if (snapshot.exists) {
        UserModel user = UserModel.fromDocumentSnapshot(snapshot);
        return user;
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching user information: $e');
      return null;
    }
  }
}
