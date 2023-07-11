import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String image;
  final String cat_name;

  CategoryModel({
    required this.id,
    required this.image,
    required this.cat_name,
    // required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'cat_name':cat_name,
    };
  }


  CategoryModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        image = doc.data()!["image"],
        cat_name = doc.data()!["cat_name"];
}
