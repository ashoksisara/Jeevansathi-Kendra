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
  TextEditingController? siblingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
    this.siblingController,
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
        siblingController = TextEditingController(text: ''),
        pageloader = false;
}
