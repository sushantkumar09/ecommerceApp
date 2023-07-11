import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/models/product_model.dart';
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
    try{
  QuerySnapshot<Map<String, dynamic>> snapshot =
  await _db.collectionGroup("product").get();
  print("${snapshot.docs} best Products");
  return snapshot.docs
      .map((docSnapshot) => ProductModel.fromDocumentSnapshot(docSnapshot))
      .toList();
}catch(e){
      showMessage((e.toString()));
      return[];
    }

}

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _db
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
}
