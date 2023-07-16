// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/constants/routes.dart';
import 'package:ecommerce/firebase_helper/firebase_firestore_helper.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:ecommerce/screens/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(String amount, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Sushant Kumar',
                  googlePay: gpay))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (err) {
      showMessage(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        bool value = await FirebaseFirestoreHelper.instance
            .uploadOrderedProductFirebase(
                appProvider.getBuyProductsList, context, "Paid");

        appProvider.clearBuyProduct();
        if (value) {
          Future.delayed(const Duration(seconds: 2), () {
            Routes.instance.push(const CustomBottomBar(), context);
          });
        }
      });
    } catch (e) {
      showMessage(e.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51NUNKKSF58QE4ZfTGxFSvihhCWWlfHOrzKs3QxTFB4cuuk1N72fdYIkT6rh1c2nM2NO5FDX36Xg8ka3lJIHDEdXv00Sh8YQvIi ',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
