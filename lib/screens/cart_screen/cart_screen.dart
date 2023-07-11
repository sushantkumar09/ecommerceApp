import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:ecommerce/screens/cart_screen/single_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int qty = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colo,
        title: const Text(
          "Cart Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body:appProvider.getCartProductList.isEmpty?const Center(child: Text("Cart is empty"),): ListView.builder(
        itemCount: appProvider.getCartProductList.length,
        itemBuilder: (context, index) {
          return SingleCartItem(singleProduct: appProvider.getCartProductList[index],);
        },
      ),
    );
  }
}
