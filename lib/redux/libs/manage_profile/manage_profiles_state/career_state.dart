import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/models_response/manage_profile/get_manage_profile/career_get_response.dart';

import '../../../../enums/enums.dart';

class CareerState {
  final CareerGetResponse? careerGetResponse;
  bool? isLoading;
  var list = <CareerViewModel>[];
  var delIndex;
  bool? isDelete;
  bool? update_changes;
  int? index;
  bool? saveChanges;
  BusinessType businessType = BusinessType.Private;
  Occupation occupation = Occupation.Job;
  dynamic job_type_value;
  dynamic income_list_value;

  CareerState(
      {this.saveChanges,
      this.isDelete,
      this.update_changes,
      this.index,
      this.delIndex,
      this.isLoading,
      this.careerGetResponse});

  CareerState.initialState()
      : careerGetResponse = CareerGetResponse.initialState(),
        isLoading = false,
        update_changes = false,
        saveChanges = false,
        isDelete = false;
}
