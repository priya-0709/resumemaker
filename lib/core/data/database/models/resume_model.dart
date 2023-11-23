import 'dart:convert';

ResumeModel resumeModelFromJson(String str) =>
    ResumeModel.fromJson(json.decode(str));

String resumeModelToJson(ResumeModel data) => json.encode(data.toJson());

class ResumeModel {
  final String? fresherOrExperience;
  final String? address;
  final String? collegeName;
  final String? dateOfBirth;
  final String? degree;
  final String? designation;
  final String? email;
  final String? endYear;
  final String? experienceOfYear;
  final String? uid;
  final String? mobileNumber;
  final String? name;
  final String? skill;
  final String? startYear;
  final DateTime? createdAt;
  final DateTime? updateAt;

  ResumeModel({
    this.fresherOrExperience,
    this.address,
    this.collegeName,
    this.dateOfBirth,
    this.degree,
    this.designation,
    this.email,
    this.endYear,
    this.experienceOfYear,
    this.uid,
    this.mobileNumber,
    this.name,
    this.skill,
    this.startYear,
    this.createdAt,
    this.updateAt,
  });

  factory ResumeModel.fromJson(Map<String, dynamic> json) => ResumeModel(
        fresherOrExperience: json["FresherOrExperience"],
        address: json["address"],
        collegeName: json["collegeName"],
        dateOfBirth: json["dateOfBirth"],
        degree: json["degree"],
        designation: json["designation"],
        email: json["email"],
        endYear: json["endYear"],
        experienceOfYear: json["experienceOfYear"],
        uid: json["uid"],
        mobileNumber: json["mobileNumber"],
        name: json["name"],
        skill: json["skill"],
        startYear: json["startYear"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"].toString()),
        updateAt: json["updateAt"] == null
            ? null
            : DateTime.parse(json["updateAt"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "FresherOrExperience": fresherOrExperience,
        "address": address,
        "collegeName": collegeName,
        "dateOfBirth": dateOfBirth,
        "degree": degree,
        "designation": designation,
        "email": email,
        "endYear": endYear,
        "experienceOfYear": experienceOfYear,
        "uid": uid,
        "mobileNumber": mobileNumber,
        "name": name,
        "skill": skill,
        "startYear": startYear,
        "createdAt": createdAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
      };
}
