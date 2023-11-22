import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? id;
  final String? name;
  final double? price;
  final int? quantity;
  final double? productTotal;
  final String? category;
  final DateTime? createdAt;
  final DateTime? updateAt;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.productTotal,
    this.category,
    this.createdAt,
    this.updateAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"] == null ? 0.0 : double.parse(json["price"].toString()),
        quantity: json["quantity"] == null ? 0 : int.parse(json["quantity"].toString()),
        productTotal: json["productTotal"] == null ? 0.0 : double.parse(json["productTotal"].toString()),
        category: json["category"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updateAt: json["updateAt"] == null ? null : DateTime.parse(json["updateAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "productTotal": productTotal,
        "category": category,
        "createdAt": createdAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
      };
}
