import 'package:flutter/cupertino.dart';
import '../../data/models/products_model.dart';

class HomeProvider with ChangeNotifier {
  bool _sliderCollapsed = true;
  bool _settingsTapped = false;
  List<Products> _products = [];

  get isSliderCollapsed => _sliderCollapsed;
  get isSettingsTapped => _settingsTapped;
  get getProducts => _products;
  get getProductsLength => _products.length;
  get getTotalPrice {
    double totalPrice = 0;
    for (var element in _products) {
      totalPrice = totalPrice + element.price * element.quantity;
    }
    return totalPrice;
  }

  setSliderCollapsed(bool value) {
    _sliderCollapsed = value;
    notifyListeners();
  }

  setSettingsTapped(bool value) {
    _settingsTapped = value;
    notifyListeners();
  }

  addAllProducts({required List<Products> products}) {
    List<Products> allProducts = [];
    for (var item in products) {
      allProducts.add(item);
    }
    _products = allProducts;
    notifyListeners();
  }

  deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  updateProductQuantity(int index, int quantity) {
    _products[index].quantity = quantity;
    notifyListeners();
  }
}
