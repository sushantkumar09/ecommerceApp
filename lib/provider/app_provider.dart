import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/firebase_helper/firebase_storage_helper.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier {
  final List<ProductModel> _buyProductList = [];

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

  //// total price
  double totalPrice() {
    double totalPrice = 0.0;

    for (var element in _cartProductList) {
      totalPrice += double.parse(element.price) * element.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  /// buy product
  ///
  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductsList => _buyProductList;
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
