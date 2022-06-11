import 'package:flutter/cupertino.dart';
import '../../data/models/products_model.dart';

class HomeProvider with ChangeNotifier {
  bool _sliderCollapsed = true;
  bool _settingsTapped = false;
  bool _showBottomItems = false;
  String _selectedView = 'QUICK_ADD';
  String _categoryItemName = '';
  String _searchText = '';
  final List<Products> _products = [];


  get isSliderCollapsed => _sliderCollapsed;
  get isSettingsTapped => _settingsTapped;
  get isShowedBottomItem => _showBottomItems;
  get getSelectedView => _selectedView;
  get getCategoryItemName => _categoryItemName;
  get getSearchText => _searchText;
  get getProducts => _products;
  get getProductsLength => _products.length;
  get getTotalPrice {
    double totalPrice = 0;
    for (var element in _products) {
      totalPrice = totalPrice + double.parse(element.price) * element.quantity;
    }
    return totalPrice;
  }

  get getTotalDiscount {
    double totalDiscount = 0;
    for(var element in _products){
      double discountPrice = 0;
      if(element.specialPrice != 0){
        discountPrice = element.price - element.specialPrice;
      }
      else{
        discountPrice = 0;
      }
      totalDiscount = totalDiscount + discountPrice;
    }
    return totalDiscount;
  }

  void setSliderCollapsed(bool value) {
    _sliderCollapsed = value;
    notifyListeners();
  }

  void setSettingsTapped(bool value) {
    _settingsTapped = value;
    notifyListeners();
  }

  void setShowBottomItem(bool value) {
    _showBottomItems = value;
    notifyListeners();
  }

  void setSelectedView(String value) {
    _selectedView = value;
    notifyListeners();
  }

  void setCategoryItemName(String value) {
    _categoryItemName = value;
    notifyListeners();
  }

  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  void addProduct({required Products product}) {
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

  void deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void updateProductQuantity(int index, int quantity) {
    _products[index].quantity = quantity;
    notifyListeners();
  }
}
