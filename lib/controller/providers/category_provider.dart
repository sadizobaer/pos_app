import 'package:flutter/cupertino.dart';
import '../../pages/category_product_model.dart';

class CategoryProvider with ChangeNotifier {
  bool _sliderCollapsed = true;
  bool _settingsTapped = false;
  final List<CategoryProductModel> _products = [
    CategoryProductModel('assets/demo_images/demo0.png', 'Bata Shoe', 2, 120),
    CategoryProductModel('assets/demo_images/demo1.png', 'Bata Shoe', 2, 100),
    CategoryProductModel('assets/demo_images/demo2.png', 'Bata Shoe', 2, 80),
    CategoryProductModel('assets/demo_images/demo3.png', 'Bata Shoe', 2, 300),
  ];

  get isSliderCollapsed => _sliderCollapsed;
  get isSettingsTapped => _settingsTapped;
  get getProducts => _products;
  get getProductsLength => _products.length;
  get getTotalPrice {
    double totalPrice = 0;
    for (var element in _products) {
      totalPrice =
          totalPrice + element.productPrice! * element.productQuantity!;
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

  addProduct(
      {String? imageUrl, String? productName, int? quantity, double? price}) {
    _products.add(
      CategoryProductModel(imageUrl, productName, quantity, price),
    );
    notifyListeners();
  }

  deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  updateProductQuantity(int index, int quantity) {
    _products[index].productQuantity = quantity;
    notifyListeners();
  }
}
