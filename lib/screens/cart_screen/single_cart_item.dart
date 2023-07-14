import 'package:ecommerce/constants/constants.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;

  const SingleCartItem({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;

  @override
  void initState() {
    // TODO: implement initState
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
              flex: 2,
              child: SizedBox(
                  height: 140,
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(alignment: Alignment.bottomRight, children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  child: Text(
                                    widget.singleProduct.prod_name,
                                    // widget.singleProduct.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        if (qty > 1) {
                                          setState(() {
                                            qty--;
                                          });
                                          appProvider.updateQty(
                                              widget.singleProduct, qty);
                                        }
                                      },
                                      padding: EdgeInsets.zero,
                                      child: const CircleAvatar(
                                        maxRadius: 13,
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                    Text(
                                      // qty.toString(),
                                      "$qty",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    CupertinoButton(
                                      onPressed: () {
                                        setState(() {
                                          qty++;
                                        });
                                        appProvider.updateQty(
                                            widget.singleProduct, qty);
                                      },
                                      padding: EdgeInsets.zero,
                                      child: const CircleAvatar(
                                        maxRadius: 13,
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        if (!appProvider.getFavouriteProductList
                                            .contains(widget.singleProduct)) {
                                          appProvider.addFavouriteProduct(
                                              widget.singleProduct);
                                          showMessage("Added to wishlist");
                                        } else {
                                          appProvider.removeFavouriteProduct(
                                              widget.singleProduct);
                                          showMessage("Removed to wishlist");
                                        }
                                      },
                                      child: Text(
                                        appProvider.getFavouriteProductList
                                                .contains(widget.singleProduct)
                                            ? "Remove to wishlist"
                                            : "Add to wishlist",
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              // "\$${widget.singleProduct.price.toString()}",
                              "\$${widget.singleProduct.price.toString()}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              appProvider
                                  .removeCartProduct(widget.singleProduct);
                              showMessage("Removed from cart");
                            },
                            child: const CircleAvatar(
                              maxRadius: 13,
                              child: Icon(
                                Icons.delete,
                                size: 17,
                              ),
                            )),
                      ])))),
        ],
      ),
    );
  }
}
