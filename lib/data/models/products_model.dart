// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);
import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<Products>? data;
  Links links;
  Meta meta;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        data: json["data"] == null
            ? null
            : List<Products>.from(
                json["data"].map((x) => Products.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };
}

class Products {
  Products({
    required this.id,
    required this.datetime,
    required this.name,
    required this.slug,
    required this.sku,
    required this.price,
    required this.quantity,
    this.maxQuantity = 0,
    required this.isInStock,
    this.image,
    required this.specialPrice,
    this.specialStartDate,
    this.specialEndDate,
  });

  int id;
  DateTime datetime;
  String name;
  String slug;
  String sku;
  dynamic price;
  int quantity;
  int maxQuantity;
  bool isInStock;
  dynamic image;
  dynamic specialPrice;
  dynamic specialStartDate;
  dynamic specialEndDate;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        datetime: DateTime.parse(json["datetime"]),
        name: json["name"],
        slug: json["slug"],
        sku: json["sku"],
        price: json["price"],
        quantity: json["quantity"],
        isInStock: json["is_in_stock"],
        image: json["image"],
        specialPrice: json["special_price"],
        specialStartDate: json["special_start_date"],
        specialEndDate: json["special_end_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "datetime": datetime.toIso8601String(),
        "name": name,
        "slug": slug,
        "sku": sku,
        "price": price,
        "quantity": quantity,
        "is_in_stock": isInStock,
        "image": image,
        "special_price": specialPrice,
        "special_start_date": specialStartDate,
        "special_end_date": specialEndDate,
      };
}

class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  int currentPage;
  dynamic from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  dynamic to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  dynamic url;
  dynamic label;
  dynamic active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
