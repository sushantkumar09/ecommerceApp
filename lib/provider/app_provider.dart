import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  //for cart
  final List<ProductModel> _cartProductList = [];

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }
  List<ProductModel> get getCartProductList => _cartProductList;

  //for favourite

  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }
  List<ProductModel> get getFavouriteProductList =>  _favouriteProductList;


}
