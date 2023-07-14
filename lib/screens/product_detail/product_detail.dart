import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/constants/routes.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:ecommerce/screens/account_screen/account_screen.dart';
import 'package:ecommerce/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce/screens/favourite_screen/favourite_screeen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;

  const ProductDetails({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance.push(CartScreen(), context);
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body:
          // SingleChildScrollView(
          //   child:
          Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                child: Image.network(
                  widget.singleProduct.image,
                  height: 400,
                  width: 400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.singleProduct.prod_name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                              !widget.singleProduct.isFavourite;
                        });
                        if (widget.singleProduct.isFavourite) {
                          appProvider.addFavouriteProduct(widget.singleProduct);
                        } else {
                          appProvider.removeFavouriteProduct(widget.singleProduct);
                        }
                      },
                      icon: Icon(appProvider.getFavouriteProductList.contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border),
                  )],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.singleProduct.description),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (quantity >= 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              // Spacer(),
              const SizedBox(
                height: 24,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: quantity);
                        appProvider.addCartProduct(productModel);
                        showMessage("Added to cart");

                        // Routes.instance.push(CartScreen(), context);
                      },
                      child: const Text("ADD TO CART")),
                  const SizedBox(
                    width: 24,
                  ),
                  SizedBox(
                    height: 35,
                    width: 130,
                    child: ElevatedButton(
                      onPressed: () {
                        // Routes.instance.push(AccountScreen(), context);
                        // Routes.instance.push(FavouriteScreen(), context);
                      },
                      child:const  Text("BUY"),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
