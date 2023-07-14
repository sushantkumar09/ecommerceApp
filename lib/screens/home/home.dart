import 'package:ecommerce/constants/routes.dart';
import 'package:ecommerce/firebase_helper/firebase_firestore_helper.dart';
import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_model.dart';
import 'package:ecommerce/provider/app_provider.dart';
import 'package:ecommerce/screens/category_view/category_view.dart';
import 'package:ecommerce/screens/product_detail/product_detail.dart';
import 'package:ecommerce/widgets/top_titles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  // UserService _userService = UserService();
  // UserModel? _user;



  bool isLoading = false;

  @override

  void initState() {
    // TODO: implement initState
    // AppProvider appProvider = Provider.of<AppProvider>(context,listen: false);
    // appProvider.getUserInformation;
    // fetchUserInformation();

    getCategoryList();
    super.initState();
  }
  // void fetchUserInformation() async {
  //   UserModel? user = await _userService.getUserInformation();
  //   setState(() {
  //     _user = user;
  //   });
  // }



  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    // productModelList.shuffle();





    print(productModelList);
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TopTitles(
                            title: "",
                            subtitle: "Ecommerce App",
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(hintText: "Search"),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    categoriesList.isEmpty
                        ? const Center(
                            child: Text("Category list is empty"),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categoriesList
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: CupertinoButton(
                                          onPressed: () {
                                            Routes.instance.push(
                                                CategoryView(
                                                  categoryModel: e,
                                                ),
                                                context);
                                          },
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 6,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(
                                                e.image,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                    const Padding(
                      padding: EdgeInsets.only(top: 12.0, left: 12, right: 12),
                      child: Text(
                        "Best Products",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    productModelList.isEmpty
                        ? const Center(
                            child: Text("Product List is empty"),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),

                            child: GridView.builder(
                                padding: const EdgeInsets.only(bottom: 50),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: productModelList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        childAspectRatio: 0.7,
                                        crossAxisCount: 2),
                                itemBuilder: (ctx, index) {
                                  ProductModel singleProduct =
                                      productModelList[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Image.network(
                                          singleProduct.image,
                                          height: 100,
                                          width: 100,
                                        ),
                                        const SizedBox(
                                          height: 12.0,
                                        ),
                                        Text(
                                          singleProduct.prod_name,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Price: \$${singleProduct.price}"),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: 140,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Routes.instance.push(
                                                  ProductDetails(
                                                      singleProduct:
                                                          singleProduct),
                                                  context);
                                            },
                                            child: const Text(
                                              "Buy",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                  ],
                ),
              ));
  }
}
//
// List<ProductModel> bestProduct = [
//   ProductModel(
//       image:
//           "https://img.etimg.com/photo/msid-93619818,imgsize-70268/AppleLaptops.jpg",
//       id: "1",
//       name: "iPhone",
//       price: 1000,
//       description: "This is phone",
//       isFavourite: false),
//   ProductModel(
//       image:
//           "https://img.etimg.com/photo/msid-93619818,imgsize-70268/AppleLaptops.jpg",
//       id: "1",
//       name: "Banana",
//       price: 1000,
//       description: "This is phone",
//       isFavourite: false),
//   ProductModel(
//       image:
//           "https://img.etimg.com/photo/msid-93619818,imgsize-70268/AppleLaptops.jpg",
//       id: "1",
//       name: "Banana",
//       price: 1000,
//       description: "This is phone",
//       isFavourite: false),
//   ProductModel(
//       image:
//           "https://img.etimg.com/photo/msid-93619818,imgsize-70268/AppleLaptops.jpg",
//       id: "1",
//       name: "Banana",
//       price: 1000,
//       description: "This is phone",
//       isFavourite: false),
// ];
