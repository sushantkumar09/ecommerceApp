import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;

  String? image;
  final String id;
  final String email;

  UserModel({
    required this.name,
    required this.id,
    required this.email,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'email': email,
      'image': image,
    };
  }

  factory UserModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return UserModel(
      name: data?['name'] ?? 'no name',
      id: doc.id,
      email: data?['email'],
      image: data?['image'],
    );
  }
// UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
//     : id = doc.id,
//       name = doc.data()?['name'] ?? 'no name',
//       email = doc.data()?['email'];
//       // image = doc.data()?['image'];

// UserModel copyWith({
//   String? user_name,
//   // image,
// }) =>
//     UserModel(
//       name: name ?? this.name,
//       id: id,
//       email: email,
//       // image: image ?? this.image,
//     );
}
//
// class CategoryModel {
//   final String id;
//   final String image;
//   final String cat_name;
//
//   CategoryModel({
//     required this.id,
//     required this.image,
//     required this.cat_name,
//     // required this.name,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'image': image,
//       'cat_name':cat_name,
//     };
//   }
//
//
//   CategoryModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
//       : id = doc.id,
//         image = doc.data()!["image"],
//         cat_name = doc.data()!["cat_name"];
// }
