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
        body: FutureBuilder(
          future: FirebaseFirestoreHelper.instance.getUserOrder(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty || snapshot.data == null) {
              return const Center(
                child: Text("No orders yet"),
              );
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  OrderModel orderModel = snapshot.data![index];
                  return ExpansionTile(
                      title: Text("${orderModel.payment}"),
                    children: [
                      ListTile()
                    ],
                  );
                });
          },
        ));
  }
}
