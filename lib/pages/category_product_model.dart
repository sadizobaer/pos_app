class CategoryProductModel {
  String? productImage;
  String? productName;
  int? productQuantity;
  double? productPrice;

  CategoryProductModel(this.productImage, this.productName,
      this.productQuantity, this.productPrice);

  Map<String, dynamic> toJson() => {
        "productImage": productImage ?? "",
        "productName": productName ?? "",
        "productQuantity": productQuantity ?? 0,
        "productPrice": productPrice ?? 0.0,
      };
}
