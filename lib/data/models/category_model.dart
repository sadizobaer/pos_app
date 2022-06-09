// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    required this.data,
  });

  List<CategoryData>? data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        data: json["data"] == null
            ? null
            : List<CategoryData>.from(
                json["data"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryData {
  CategoryData({
    required this.id,
    required this.name,
    required this.slug,
    this.image,
    this.children,
  });

  int id;
  String name;
  String slug;
  dynamic image;
  List<dynamic>? children;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        children: json["children"] == null
            ? null
            : List<dynamic>.from(json["children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "children": children == null
            ? null
            : List<dynamic>.from(children!.map((x) => x)),
      };
}
