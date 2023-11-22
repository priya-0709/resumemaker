import 'dart:convert';

BusinessModel businessModelFromJson(String str) => BusinessModel.fromJson(json.decode(str));

String businessModelToJson(BusinessModel data) => json.encode(data.toJson());

class BusinessModel {
  final String? id;
  final String? name;
  final String? email;
  final String? mobileNumber;
  final String? address;
  final String? businessLogo;
  final String? businessType;

  BusinessModel({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.address,
    this.businessLogo,
    this.businessType,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json, {bool listDecode = false}) => BusinessModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        address: json["address"],
        businessLogo: json["businessLogo"],
        businessType: json["businessType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobileNumber": mobileNumber,
        "address": address,
        "businessLogo": businessLogo,
        "businessType": businessType,
      };
}
