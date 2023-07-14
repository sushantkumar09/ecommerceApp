// import 'dart:io';
//
// import 'package:ecommerce/constants/constants.dart';
// import 'package:ecommerce/constants/routes.dart';
// import 'package:ecommerce/firebase_helper/firebase_storage_helper.dart';
// import 'package:ecommerce/models/user_model.dart';
// import 'package:ecommerce/provider/app_provider.dart';
// import 'package:ecommerce/widgets/primary_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
//
// class EditProfile extends StatefulWidget {
//   const EditProfile({Key? key}) : super(key: key);
//
//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   UserService _userService = UserService();
//   UserModel? _user;
//   File? image;
//
//   void initState() {
//     // TODO: implement initState
//     fetchUserInformation();
//     super.initState();
//   }
//
//   void fetchUserInformation() async {
//     UserModel? user = await _userService.getUserInformation();
//     setState(() {
//       _user = user;
//     });
//   }
//
//   void takePicture() async {
//     XFile? value = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (value != null) {
//       setState(() {
//         image = File(value.path);
//       });
//     }
//   }
//   // Future<void> uploadImage() async {
//   //   if (image != null) {
//   //     try {
//   //       final storageRef = firebase_storage.FirebaseStorage.instance
//   //           .ref()
//   //           .child('user_images/${_user!.id}.jpg');
//   //       await storageRef.putFile(image!);
//   //       final imageUrl = await storageRef.getDownloadURL();
//   //       setState(() {
//   //         _user = _user!.copyWith(image: imageUrl);
//   //       });
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Image uploaded successfully')),
//   //       );
//   //     } catch (error) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Image upload failed')),
//   //       );
//   //     }
//   //   }
//   // }
//
//   TextEditingController textEditingController =TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(
//       context,
//     );
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Profile",
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         children: [
//           image==null?
//
//           CupertinoButton(
//             onPressed: () {
//               takePicture();
//             },
//             child:const CircleAvatar(
//               radius: 80,
//               child: Icon(Icons.camera_alt_outlined) ,
//             ),
//           ):CupertinoButton(child: CircleAvatar(
//             backgroundImage: FileImage(image!),
//             radius: 70,
//           ), onPressed: (){
//             takePicture();
//           }),
//           const SizedBox(
//             height: 12,
//           ),
//           TextFormField(
//             controller: textEditingController,
//             decoration: InputDecoration(hintText: _user!.name),
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           PrimaryButton(onPressed: () async {
//             UserModel userModel = appProvider.getUserInformation.copyWith(name: textEditingController.text);
//             appProvider.updateUserInfoFirebase(context, userModel, image);
//             showMessage("Successfully updated profile");
//             // String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(image!);
//             // print("teseting 123");
//             // print(imageUrl);
//             // uploadImage();
//             // Navigator.pop(context);
//
//           }, title: "Update")
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  File? _pickedImage;
  bool _isLoading = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> saveChanges() async {
    setState(() {
      _isLoading = true;
    });

    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    try {
      if (_pickedImage != null) {
        final storageRef = firebase_storage.FirebaseStorage.instance.ref('user_images/$userId.jpg');
        await storageRef.putFile(_pickedImage!);
        final imageUrl = await storageRef.getDownloadURL();
        await FirebaseFirestore.instance.collection('users').doc(userId).update({'image': imageUrl});
      }

      if (_nameController.text.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(userId).update({'name': _nameController.text});
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
      Navigator.of(context).pop(); // Pop back to previous screen after successful update
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user!.uid;

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userData = userDoc.data() as Map<String, dynamic>?;

    if (userData != null) {
      _nameController.text = userData['name'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Expanded(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _pickedImage != null
                      ? FileImage(_pickedImage!) as ImageProvider<Object>
                      : AssetImage('assets/default_image.png') as ImageProvider<Object>,
                  child: _pickedImage == null
                      ? Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  )
                      : null,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Current Name',
              ),
            ),
            SizedBox(height: 16),
            CupertinoButton(
              onPressed: _isLoading ? null : saveChanges,
              child: _isLoading ? CircularProgressIndicator() : Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
