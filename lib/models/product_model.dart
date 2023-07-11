import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String image;
  final String id;

  bool isFavourite;
  final String pname;
  final String prod_name;
  final String price;
  final String description;

  ProductModel({
    required this.image,
    required this.id,
    required this.pname,
    required this.prod_name,
    required this.price,
    required this.description,
    this.qty,
    required this.isFavourite,
  });

  int? qty;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'pname': pname,
      'prod_name': prod_name,
      'price': price,
      'qty':qty,
      'description': description,
      'isFavourite': isFavourite,
    };
  }

  ProductModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      // : id = doc.id,
      //   name = doc.data()!['name'],
      //   description = doc.data()!['description'],
      //   image = doc.data()!['image'],
      //   // isFavourite = false,
      //   price = doc.data()!['price'];
      : id = doc.id,
        pname = doc.data()!['name'] ?? 'no name',
        prod_name = doc.data()!['prod_name'],
        description = doc.data()!['description'],
        image = doc.data()!['image'],
        qty = doc.data()!['qty'],
        isFavourite = false,
        price = doc.data()!['price'];


  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        id: id,
        pname: pname,
        description: description,
        image: image,
        isFavourite: isFavourite,
        qty: qty ?? this.qty,
        price: price,
        prod_name: prod_name,
      );

}
