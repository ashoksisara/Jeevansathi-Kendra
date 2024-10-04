import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/family_get_response.dart';
import 'package:flutter/material.dart';

import '../../../../enums/enums.dart';

class FamilyState {
  bool? isloading;
  bool? pageloader;
  FamilyGetResponse? familyGetResponse;
  TextEditingController? fatherController = TextEditingController();
  TextEditingController? fatherEducationController = TextEditingController();
  TextEditingController? fatherOccupationController = TextEditingController();
  AliveStatus fatherStatus = AliveStatus.Alive;
  TextEditingController? motherController = TextEditingController();
  TextEditingController? motherEducationController = TextEditingController();
  TextEditingController? motherOccupationController = TextEditingController();
  AliveStatus motherStatus = AliveStatus.Alive;

  List<dynamic> siblingList = [];

  final formKey = GlobalKey<FormState>();
  SiblingType siblingType = SiblingType.Brother;

  FamilyData? familyData;

  FamilyState({
    this.isloading,
    this.pageloader,
    this.familyGetResponse,
    this.fatherController,
    this.fatherEducationController,
    this.fatherOccupationController,
    this.motherEducationController,
    this.motherOccupationController,
    this.motherController,
    this.familyData,
  });

  FamilyState.initialState()
      : isloading = false,
        familyData = null,
        fatherController = TextEditingController(text: ''),
        motherController = TextEditingController(text: ''),
        motherOccupationController = TextEditingController(text: ''),
        motherEducationController = TextEditingController(text: ''),
        fatherOccupationController = TextEditingController(text: ''),
        fatherEducationController = TextEditingController(text: ''),
        pageloader = false;
}

class SiblingModel {
  String? name;
  String? maritalStatus;
  String? education;
  dynamic occupation;
  dynamic type;
  TextEditingController? nameController;
  TextEditingController? educationController;

  SiblingModel(
      {this.name,
      this.type,
      this.occupation,
      this.education,
      this.educationController,
      this.nameController,
      this.maritalStatus});

  factory SiblingModel.fromJson(Map<String, dynamic> json) => SiblingModel(
    name: json["sibling_name"],
    maritalStatus: json["sibling_marital_status"],
    education: json["sibling_education"],
    occupation: json["sibling_occupation"],
    type: json["sibling_type"],
  );

  Map<String, dynamic> toJson() => {
    "sibling_name": name,
    "sibling_marital_status": maritalStatus,
    "sibling_education": education,
    "sibling_occupation": occupation,
    "sibling_type": type,
  };
}
