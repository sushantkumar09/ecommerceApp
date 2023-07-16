import 'package:ecommerce/firebase_helper/firebase_firestore_helper.dart';
import 'package:ecommerce/models/order_model.dart';
import 'package:flutter/material.dart';

class OrdeScreen extends StatefulWidget {
  const OrdeScreen({Key? key}) : super(key: key);

  @override
  State<OrdeScreen> createState() => _OrdeScreenState();
}

class _OrdeScreenState extends State<OrdeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Your orders",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body:StreamBuilder(
          stream: Stream.fromFuture( FirebaseFirestoreHelper.instance.getUserOrder()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty || snapshot.data == null) {
              return const Center(
                child: Text("No orders yet"),
              );
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.all(12.0),
                itemBuilder: (context, index) {
                  OrderModel orderModel = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      collapsedShape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.3)),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.3)),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            child: Image.network(
                              orderModel.products[0].image,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderModel.products[0].prod_name,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                orderModel.products.length > 1
                                    ? SizedBox.fromSize()
                                    : Column(
                                        // children: [
                                        //   Text(
                                        //     "Quanity: ${orderModel.products[0].qty.toString()}",
                                        //     style: const TextStyle(
                                        //       fontSize: 12.0,
                                        //     ),
                                        //   ),
                                        //   const SizedBox(
                                        //     height: 4.0,
                                        //   ),
                                        // ],
                                      ),
                                Text(
                                  "Total Price: \$${orderModel.totalPrice.toString()}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  "Order Status: ${orderModel.status}",
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      children: orderModel.products.length > 1
                          ? [
                              const Text("Details"),
                              Divider(color: Theme.of(context).primaryColor),
                              ...orderModel.products.map((singleProduct) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 6.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.5),
                                            child: Image.network(
                                              singleProduct.image,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  singleProduct.prod_name,
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12.0,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Quanity: ${singleProduct.qty.toString()}",
                                                      style: const TextStyle(
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12.0,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Price: \$${singleProduct.price.toString()}",
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ],
                                  ),
                                );
                              }).toList()
                            ]
                          : [],
                    ),
                  );
                },
              ),
            );
          },
        ));
  }
}
