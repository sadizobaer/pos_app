import 'package:flutter/cupertino.dart';
import '../../data/models/products_model.dart';

class HomeProvider with ChangeNotifier {
  bool _sliderCollapsed = true;
  bool _settingsTapped = false;
  String _selectedView = 'QUICK_ADD';
  String _searchText = '';
  final List<Products> _products = [];


  get isSliderCollapsed => _sliderCollapsed;
  get isSettingsTapped => _settingsTapped;
  get getSelectedView => _selectedView;
  get getSearchText => _searchText;
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

  setSelectedView(String value) {
    _selectedView = value;
    notifyListeners();
  }

  setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  addProduct({required Products product}) {
    _products.add(Products(
      id: product.id,
      image: product.image,
      datetime: product.datetime,
      name: product.name,
      slug: product.slug,
      sku: product.sku,
      price: product.price,
      quantity: 1,
      maxQuantity: product.quantity,
      isInStock: product.isInStock,
      specialPrice: product.specialPrice,
    ));
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
