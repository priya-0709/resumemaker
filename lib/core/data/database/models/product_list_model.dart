import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  final String? id;
  final String? name;
  final double? price;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updateAt;

  ProductListModel({
    this.id,
    this.name,
    this.price,
    this.category,
    this.createdAt,
    this.updateAt,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        id: json["id"],
        name: json["name"],
        price: json["price"] == null ? 0.0 : double.parse(json["price"].toString()),
        category: json["category"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"].toString()),
        updateAt: json["updateAt"] == null ? null : DateTime.parse(json["updateAt"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "category": category,
        "createdAt": createdAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
      };
}
