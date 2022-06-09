// To parse this JSON data, do
//
//     final searchProductModel = searchProductModelFromJson(jsonString);
import 'dart:convert';
import 'package:dorkar/data/models/products_model.dart';

SearchProductModel searchProductModelFromJson(String str) =>
    SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) =>
    json.encode(data.toJson());

class SearchProductModel {
  SearchProductModel({
    this.products,
  });

  List<Products>? products;

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      SearchProductModel(
        products: List<Products>.from(
            json["products"].map((x) => Products.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
