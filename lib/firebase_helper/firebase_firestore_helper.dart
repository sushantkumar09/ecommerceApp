import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('categories');

  Future<List<CategoryModel>> getCategories() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("categories").get();
    debugPrint("${snapshot.docs} best category Products");

    return snapshot.docs
        .map((docSnapshot) => CategoryModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<List<ProductModel>> getBestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collectionGroup("product").get();
      print("${snapshot.docs} best Products");
      return snapshot.docs
          .map((docSnapshot) => ProductModel.fromDocumentSnapshot(docSnapshot))
          .toList();
    } catch (e) {
      showMessage((e.toString()));
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection("categories")
          .doc(id)
          .collection("product")
          .get();
      print("${snapshot.docs} best  new Products");
      return snapshot.docs
          .map((e) => ProductModel.fromDocumentSnapshot(e))
          .toList();
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel?> getUserInformation() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snapshot.exists) {
        print("${UserModel.fromDocumentSnapshot(snapshot)} test");
        return UserModel.fromDocumentSnapshot(snapshot);
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching user information: $e");
      return null;
    }
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context,String payment) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0;
      for (var element in list) {
        totalPrice += double.parse(element.price) * element.qty!;
      }
      DocumentReference documentReference = _db
          .collection("usersOrders")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("orders")
          .doc();
      documentReference.set({
        "products": list.map((e) => e.toJson()),
        "status":"Pending",
        "totalPrice": totalPrice,
        "payment":payment,
      });
      Navigator.of(context, rootNavigator: true).pop();
      showMessage("order placed successfully");

      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();
      return false;
    }
  }
}
