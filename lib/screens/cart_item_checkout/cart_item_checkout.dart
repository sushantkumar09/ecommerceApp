import 'package:ecommerce/constants/routes.dart';
import 'package:ecommerce/firebase_helper/firebase_firestore_helper.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:ecommerce/screens/custom_bottom_bar.dart';
import 'package:ecommerce/stripe_helper/stripe_helper.dart';
import 'package:ecommerce/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCheckout extends StatefulWidget {
  const CartItemCheckout({Key? key}) : super(key: key);

  @override
  State<CartItemCheckout> createState() => _CartItemCheckoutState();
}

class _CartItemCheckoutState extends State<CartItemCheckout> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.attach_money_outlined),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2)),
              width: double.infinity,
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.credit_card),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Pay Online",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
                onPressed: () async {
                  // bool value = await FirebaseFirestoreHelper.instance
                  //     .uploadOrderedProductFirebase(
                  //         appProvider.getBuyProductsList,
                  //         context,
                  //         groupValue == 1 ? "Cash on delivery" : "Paid");
                  // appProvider.clearBuyProduct();
                  // if (value) {
                  //   Future.delayed(const Duration(seconds: 2), () {
                  //     Routes.instance.push(CustomBottomBar(), context);
                  //   });
                  // }

                  if (groupValue == 1) {
                    bool value = await FirebaseFirestoreHelper.instance
                        .uploadOrderedProductFirebase(
                        appProvider.getBuyProductsList,
                        context,
                        "Cash on delivery");

                    appProvider.clearBuyProduct();
                    if (value) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Routes.instance.push(
                             const CustomBottomBar(), context);
                      });
                    }
                  } else {

                    int value = double.parse(
                        appProvider.totalPriceBuyProductList().toString())
                        .round()
                        .toInt();
                    String totalPrice = (value * 100).toString();
                    await StripeHelper.instance
                        .makePayment(totalPrice.toString(), context);
                  }
                },
                title: "Continue ")
          ],
        ),
      ),
    );
  }
}
