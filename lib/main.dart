import 'package:ecommerce/firebase_helper/firebase_auth_helper.dart';
import 'package:ecommerce/firebase_helper/firebase_options.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:ecommerce/screens/auth_ui/welcome/welcome.dart';
import 'package:ecommerce/screens/custom_bottom_bar.dart';
import 'package:ecommerce/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'constants/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51NUNKKSF58QE4ZfTfR6IKCs4EhLZyBDreXJOTg91cmRk36E7AmWo9jEpxmzZmlFsxOwvl49stwujWYS543KatSjT00XzwQeDVX";
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> AppProvider(),
      child: MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
