// To parse this JSON data, do
//
//     final categorySearchProductModel = categorySearchProductModelFromJson(jsonString);

import 'dart:convert';

import 'package:dorkar/data/models/products_model.dart';

CategorySearchProductModel categorySearchProductModelFromJson(String str) =>
    CategorySearchProductModel.fromJson(json.decode(str));

String categorySearchProductModelToJson(CategorySearchProductModel data) =>
    json.encode(data.toJson());

class CategorySearchProductModel {
  CategorySearchProductModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Products> data;
  Links links;
  Meta meta;

  factory CategorySearchProductModel.fromJson(Map<String, dynamic> json) =>
      CategorySearchProductModel(
        data:
            List<Products>.from(json["data"].map((x) => Products.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}
