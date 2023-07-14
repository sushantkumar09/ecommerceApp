import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product_model.dart';

class OrderModel {
  final String orderId;
  final String payment;
  final String status;
  double totalPrice;
  List<ProductModel> products;

  OrderModel({
    required this.orderId,
    required this.payment,
    required this.status,
    required this.totalPrice,
    required this.products,
  });
  Map<String, dynamic> toMap() {
    List<dynamic> productsList = products.map((product) => product.toJson()).toList();

    return {
      'orderID': orderId,
      'payment': payment,
      'status' :status,
      'totalPrice': totalPrice,
      'products': productsList,
    };
  }



  static OrderModel fromMap(Map<String, dynamic> map) {
    List<dynamic> productMaps = map['products'] ?? [];
    List<ProductModel> products = productMaps.map((productMap) => ProductModel.fromDocumentSnapshot(productMap)).toList();

    return OrderModel(
      orderId: map['orderId'] ?? '',
      payment: map['payment'] ?? '',
      status: map['status'],
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      products: products,
    );
  }
  // factory OrderModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
  //   List<dynamic> productMap = doc.data()!['products'];
  //
  //   List<ProductModel> productsList =
  //   productMap.map((product) => ProductModel.fromDocumentSnapshot(product)).toList();
  //
  //   return OrderModel(
  //     orderId: doc.id,
  //     payment: doc.data()!['payment'],
  //     status: doc.data()!['status'],
  //     totalPrice: doc.data()!['totalPrice'],
  //     products: productsList,
  //   );
  // }
  // factory OrderModel.fromJson(Map<String, dynamic> json) {
  //   List<ProductModel> productMap = json["products"];
  //   return OrderModel(
  //       orderId: json["orderId"],
  //       products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
  //       totalPrice: json["totalPrice"],
  //       status: json["status"],
  //       payment: json["payment"]);
  // }






}

// class OrderModel {
//   String
//
//    String orderId;
//
//
//
//   String orderID;
//   String payment,String Status;
//   double totalPrice;
//   List<ProductModel> products;
//
//   OrderModel({
//     required this.orderID,
//     required this.paymentStatus,
//     required this.totalPrice,
//     required this.products,
//   });
//
//
// }
