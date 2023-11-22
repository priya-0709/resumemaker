import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  final String? id;
  final String? name;
  final String? mobileNumber;
  final String? email;
  final String? address;

  CustomerModel({
    this.id,
    this.name,
    this.mobileNumber,
    this.email,
    this.address,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "email": email,
        "address": address,
      };
}
