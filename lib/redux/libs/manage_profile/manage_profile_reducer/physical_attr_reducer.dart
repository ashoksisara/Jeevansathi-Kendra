import 'package:active_matrimonial_flutter_app/enums/enums.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/physical_attributes_get_response.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/physical_attr_state.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../manage_profile_middleware/manage_profile_update_middlewares.dart';

class PhysicalAttrLoader {}

PhysicalAttrState? physical_attr_reducer(
    PhysicalAttrState? state, dynamic action) {
  if (action is PhysicalAttrLoader) {
    state!.isLoading = !state.isLoading!;
    return state;
  }

  if (action is PhysicalAttrStoreAction) {
    state!.physicalAttrData = action.payload!.data;
    setPhysicalAttr(state);
    return state;
  }

  if (action == UpdateInfo.physicalAttr) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (state!.formKey.currentState!.validate()) {
      store.dispatch(
        physicalAttrMiddleware(
          height: state.height,
          weight: state.weightController!.text,
          eye_color: state.eyeColorController!.text,
          hair_color: state.hairColorController!.text,
          complexion: state.complexionController!.text,
          body_type: state.bodyTypeController!.text,
          body_art: state.bodyArtController!.text,
          disability: state.disability.name,
          blood_group: state.bloodGroup,
          disabilityDetails: state.disability == Disability.Yes ? state.disabilityController!.text : null
        ),
      );
    }
  }

  return state;
}

setPhysicalAttr(PhysicalAttrState? state) {
  // state!.heightController!.text = state.physicalAttrData!.height!.toString();
  state!.height = state.physicalAttrData?.height != null ? state.physicalAttrData!.height.toString() : null ;
  state.weightController!.text = state.physicalAttrData!.weight!.toString();
  state.eyeColorController!.text = state.physicalAttrData!.eyeColor!.toString();
  state.hairColorController!.text =
      state.physicalAttrData!.hairColor!.toString();
  state.complexionController!.text =
      state.physicalAttrData!.complexion!.toString();
  state.bodyTypeController!.text = state.physicalAttrData!.bodyType!.toString();
  state.bodyArtController!.text = state.physicalAttrData!.bodyArt!.toString();
  state.disabilityController!.text =
      state.physicalAttrData!.disabilityDetails ?? '';
  state.bloodGroup = state.physicalAttrData!.bloodGroup!.toString();
  state.disability = state.physicalAttrData!.disability == "No" ? Disability.No : Disability.Yes;
}

// actions
class PhysicalAttrStoreAction {
  PhysicalAttributesGetResponse? payload;

  PhysicalAttrStoreAction({this.payload});

  @override
  String toString() {
    return 'PhysicalAttrStoreAction{payload: $payload}';
  }
}
