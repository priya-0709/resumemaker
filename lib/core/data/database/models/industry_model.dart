import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

IndustryModel industryModelFromJson(String str) => IndustryModel.fromJson(json.decode(str));

String industryModelToJson(IndustryModel data) => json.encode(data.toJson());

class IndustryModel {
  final String? title;

  IndustryModel({
    this.title,
  });

  factory IndustryModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) => IndustryModel(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}
