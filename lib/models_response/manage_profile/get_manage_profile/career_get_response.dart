// To parse this JSON data, do
//
//     final careerGetResponse = careerGetResponseFromJson(jsonString);

import 'dart:convert';

CareerGetResponse careerGetResponseFromJson(String str) =>
    CareerGetResponse.fromJson(json.decode(str));

String careerGetResponseToJson(CareerGetResponse data) =>
    json.encode(data.toJson());

class CareerGetResponse {
  CareerGetResponse({
    this.data,
    this.result,
  });

  List<Data>? data;
  bool? result;

  factory CareerGetResponse.fromJson(Map<String, dynamic> json) =>
      CareerGetResponse(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "result": result,
      };

  CareerGetResponse.initialState()
      : data = [],
        result = false;
}

class Data {
  Data(
      {this.id,
      this.designation,
      this.company,
      this.start,
      this.end,
      this.present,
      this.occupation,
      this.businessType,
      this.monthlyIncome,
      this.location,
      this.jobType});

  int? id;
  String? designation;
  String? company;
  int? start;
  dynamic end;
  dynamic present;
  dynamic location;
  dynamic occupation;
  dynamic jobType;
  dynamic businessType;
  dynamic monthlyIncome;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      designation: json["designation"],
      company: json["company"],
      start: json["start"],
      end: json["end"],
      present: json["present"],
      occupation: json["occupation"],
      businessType: json["business_type"],
      monthlyIncome: json["monthly_income"],
      location: json["location"],
      jobType: json["job_type"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "designation": designation,
        "company": company,
        "start": start,
        "end": end,
        "location": location,
        "present": present,
        "occupation" :occupation,
        "business_type" : businessType,
        "monthly_income" : monthlyIncome,
        "job_type" : jobType
      };

  Data.initialState()
      : id = 0,
        designation = '',
        company = '',
        start = 0,
        end = 0,
        present = false;
}
