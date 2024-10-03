// To parse this JSON data, do
//
//     final familyGetResponse = familyGetResponseFromJson(jsonString);

import 'dart:convert';

FamilyGetResponse familyGetResponseFromJson(String str) =>
    FamilyGetResponse.fromJson(json.decode(str));

String familyGetResponseToJson(FamilyGetResponse data) =>
    json.encode(data.toJson());

class FamilyGetResponse {
  FamilyGetResponse({this.data, this.result, this.message});

  FamilyData? data;
  bool? result;

  String? message;

  factory FamilyGetResponse.fromJson(Map<String, dynamic> json) =>
      FamilyGetResponse(
        data: json["data"] == null ? null : FamilyData.fromJson(json["data"]),
        result: json["result"] == null ? null : json["result"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        "result": result == null ? null : result,
        "message": message == null ? null : message,
      };
}

class FamilyData {
  FamilyData({
    this.father,
    this.mother,
    this.sibling,
    this.fatherStatus,
    this.motherStatus,
    this.motherOccupation,
    this.motherEducation,
    this.fatherOccupation,
    this.fatherEducation
  });

  String? father;
  String? fatherEducation;
  String? fatherOccupation;
  String? fatherStatus;
  String? mother;
  String? motherEducation;
  String? motherOccupation;
  String? motherStatus;
  String? sibling;

  factory FamilyData.fromJson(Map<String, dynamic> json) => FamilyData(
        father: json["father_name"] == null ? null : json["father_name"],
        fatherEducation: json["father_education"] == null ? null : json["father_education"],
        fatherOccupation: json["father_occupation"] == null ? null : json["father_occupation"],
        fatherStatus: json["father_status"] == null ? null : json["father_status"],
        mother: json["mother_name"] == null ? null : json["mother_name"],
        motherEducation: json["mother_education"] == null ? null : json["mother_education"],
        motherOccupation: json["mother_occupation"] == null ? null : json["mother_occupation"],
        motherStatus: json["mother_status"] == null ? null : json["mother_status"],
        sibling: json["sibling"] == null ? null : json["sibling"],
      );

  Map<String, dynamic> toJson() => {
        "father_name": father == null ? null : father,
        "mother_name": mother == null ? null : mother,
        "sibling": sibling == null ? null : sibling,
        "mother_status": motherStatus == null ? null : motherStatus,
        "mother_occupation": motherOccupation == null ? null : motherOccupation,
        "mother_education": motherEducation == null ? null : motherEducation,
        "father_status": fatherStatus == null ? null : fatherStatus,
        "father_occupation": fatherOccupation == null ? null : fatherOccupation,
        "father_education": fatherEducation == null ? null : fatherEducation,
      };
}
