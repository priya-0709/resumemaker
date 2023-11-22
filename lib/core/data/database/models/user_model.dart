import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? profileImage;
  final String? backUpType;
  final DateTime? createdAt;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.profileImage,
    this.backUpType,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profileImage"],
        backUpType: json["backUpType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "profileImage": profileImage,
        "backUpType": backUpType,
        "createdAt": createdAt?.toIso8601String(),
      };
}
