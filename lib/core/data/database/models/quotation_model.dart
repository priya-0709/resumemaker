import 'dart:convert';

import 'product_model.dart';

QuotationModel quotationModelFromJson(String str) => QuotationModel.fromJson(json.decode(str));

String quotationModelToJson(QuotationModel data) => json.encode(data.toJson());

class QuotationModel {
  final String? id;
  final String? customerName;
  final String? customerMobile;
  final String? customerEmail;
  final String? customerAddress;
  final double? totalAmount;
  final List<ProductModel>? productList;
  final DateTime? createdAt;
  final DateTime? updateAt;

  QuotationModel({
    this.id,
    this.customerName,
    this.customerMobile,
    this.customerEmail,
    this.customerAddress,
    this.totalAmount,
    this.productList,
    this.createdAt,
    this.updateAt,
  });

  factory QuotationModel.fromJson(Map<String, dynamic> json, {bool listDecode = false}) => QuotationModel(
        id: json["id"],
        customerName: json["customerName"],
        customerMobile: json["customerMobile"],
        customerEmail: json["customerEmail"],
        customerAddress: json["customerAddress"],
        totalAmount: json["totalAmount"] == null ? 0.0 : double.parse(json["totalAmount"].toString()),
        productList: json["productList"] == null ? [] : (List<ProductModel>.from((listDecode == false ? json["productList"] : jsonDecode(json["productList"]))!.map((x) => ProductModel.fromJson(x)))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updateAt: json["updateAt"] == null ? null : DateTime.parse(json["updateAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerName": customerName,
        "customerMobile": customerMobile,
        "customerEmail": customerEmail,
        "customerAddress": customerAddress,
        "totalAmount": totalAmount,
        "productList": productList == null ? [] : List<ProductModel>.from(productList!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
      };
}
