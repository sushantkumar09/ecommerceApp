import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '',
        apiKey: '',
        projectId: '',
        messagingSenderId: '',
        iosBundleId: '',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:787581702914:android:691c27d1aa75b4ce80a81b',
        apiKey: 'AIzaSyAnHZaBnxzjad_a__Db37riAIJz3A6CBLM',
        projectId: 'ecommerce-45b56',
        messagingSenderId: '787581702914',
      );
    }
  }
}