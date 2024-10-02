import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profile_reducer/career_reducer.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_create_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_delete_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_get_middlewares.dart';
import '../../redux/libs/manage_profile/manage_profile_middleware/manage_profile_update_middlewares.dart';

class CareerInfo extends StatefulWidget {
  const CareerInfo({Key? key}) : super(key: key);

  @override
  State<CareerInfo> createState() => _CareerInfoState();
}

class _CareerInfoState extends State<CareerInfo> {
  final _formKey = GlobalKey<FormState>();

  var index;
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  BusinessType businessType = BusinessType.Private;
  Occupation occupation = Occupation.Job;
  dynamic jobType, monthlyIncome;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.manage_profile_career_info,
        ).build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: Const.kPaddingHorizontal,
                right: Const.kPaddingHorizontal,
                bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle(context, state),
                Form(
                  key: _formKey,
                  child: build_body(context, state),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> buildDropdownItems(jobTypes) {
    List<DropdownMenuItem> dropdownItems = [];
    jobTypes.forEach((section) {
      dropdownItems.add(
        DropdownMenuItem(
          enabled: false, // Disable selection for the title
          child: Text(
            section.key,
            style: Styles.regular_arsenic_14.copyWith(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      );

      // Add the jobs (selectable)
      section.value.forEach((key, value) {
        dropdownItems.add(
          DropdownMenuItem(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(
                value,
                style: Styles.regular_arsenic_14,
              ),
            ),
          ),
        );
      });
    });

    return dropdownItems;
  }

  Widget build_body(BuildContext maincontext, AppState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => store.dispatch(careerGetMiddleware()),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: state.manageProfileCombineState!.careerState!.list.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  boxShadow: [CommonWidget.box_shadow()]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .occupation,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                InputStyle.inputDecoration_text_field(
                                    hint: state
                                        .manageProfileCombineState!
                                        .careerState!
                                        .list[index]
                                        .occupation),
                                controller: state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .list[index]
                                    .occupation_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .type,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField<dynamic>(
                              isExpanded: true,
                              iconSize: 0.0,
                              decoration: InputDecoration(
                                hintText: "Select one",
                                isDense: true,
                                hintStyle: Styles.regular_gull_grey_12,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: MyTheme.gull_grey,
                                ),
                              ),
                              value: state
                                  .manageProfileCombineState!
                                  .careerState!
                                  .list[index].type,
                              items: buildDropdownItems(state.manageProfileCombineState!
                                  .profiledropdownResponseData!.data!.jobTypeList!),
                              onChanged: (dynamic newValue) {
                                jobType = newValue;
                                state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .list[index].type = newValue;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .public_profile_designation,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state
                                            .manageProfileCombineState!
                                            .careerState!
                                            .list[index]
                                            .designation_text),
                                controller: state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .list[index]
                                    .designation_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .public_profile_company,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state
                                            .manageProfileCombineState!
                                            .careerState!
                                            .list[index]
                                            .company_text),
                                controller: state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .list[index]
                                    .company_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .manage_profile_start,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state.manageProfileCombineState!
                                            .careerState!.list[index].start),
                                controller: state.manageProfileCombineState!
                                    .careerState!.list[index].start_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.manage_profile_end,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputStyle.inputDecoration_text_field(
                                        hint: state.manageProfileCombineState!
                                            .careerState!.list[index].end),
                                controller: state.manageProfileCombineState!
                                    .careerState!.list[index].end_controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Monthly income
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .monthly_income,
                        style: Styles.bold_arsenic_12,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      DropdownButtonFormField<dynamic>(
                        isExpanded: true,
                        iconSize: 0.0,
                        decoration: InputDecoration(
                          hintText: "Select one",
                          isDense: true,
                          hintStyle: Styles.regular_gull_grey_12,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: MyTheme.gull_grey,
                          ),
                        ),
                        value: state
                            .manageProfileCombineState!
                            .careerState!
                            .list[index].income,
                        items: state.manageProfileCombineState!
                            .profiledropdownResponseData!.data!.incomeList!.map((e) => e.value).toList()
                            .map<DropdownMenuItem<dynamic>>((e) {
                          return DropdownMenuItem<dynamic>(
                            value: e,
                            child: Text(
                              e,
                              style: Styles.regular_arsenic_14,
                            ),
                          );
                        }).toList(),
                        onChanged: (dynamic newValue) {
                          state
                              .manageProfileCombineState!
                              .careerState!
                              .list[index].income = newValue;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Status',
                              style: Styles.bold_arsenic_12,
                            ),
                            Switch(
                              value: state.manageProfileCombineState!
                                  .careerState!.list[index].present,
                              onChanged: (value) {
                                store.dispatch(CareerStatusAction(
                                    status: value,
                                    id: state.manageProfileCombineState!
                                        .careerState!.list[index].id));
                              },
                              activeColor: Colors.green,
                              activeTrackColor: MyTheme.zircon,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: MyTheme.zircon,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            state.manageProfileCombineState!.careerState!
                                .delIndex = index;

                            store.dispatch(careerDeleteMiddleware(
                                id: state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .careerGetResponse!
                                    .data![index]
                                    .id));
                          },
                          child: Container(
                            height: 45,
                            width: DeviceInfo(context).width,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: MyTheme.app_accent_color),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                            child: Center(
                              child: state.manageProfileCombineState!
                                          .careerState!.isDelete! &&
                                      state.manageProfileCombineState!
                                              .careerState!.delIndex ==
                                          index
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: MyTheme.storm_grey,
                                      ),
                                    )
                                  : Text(
                                      "Delete",
                                      style: Styles.bold_arsenic_14,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            state.manageProfileCombineState!.careerState!
                                .index = index;
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (!_formKey.currentState!.validate()) {
                              // store.dispatch(ShowMessageAction(
                              //   msg: "Form's not validated!",
                              // ));
                            } else {
                              store.dispatch(careerUpdateMiddleware(
                                  designation: state
                                      .manageProfileCombineState!
                                      .careerState!
                                      .list[index]
                                      .designation_controller
                                      .text,
                                  company: state
                                      .manageProfileCombineState!
                                      .careerState!
                                      .list[index]
                                      .company_controller
                                      .text,
                                  start: state
                                      .manageProfileCombineState!
                                      .careerState!
                                      .list[index]
                                      .start_controller
                                      .text,
                                  end: state
                                      .manageProfileCombineState!
                                      .careerState!
                                      .list[index]
                                      .end_controller
                                      .text,
                                  id: state
                                      .manageProfileCombineState!
                                      .careerState!
                                      .careerGetResponse!
                                      .data![index]
                                      .id,
                                monthlyIncome:  state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .list[index]
                                    .income,
                                type:  state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .list[index]
                                    .type,
                                businessType: state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .careerGetResponse!
                                    .data![index]
                                    .businessType,
                                occupation: state
                                    .manageProfileCombineState!
                                    .careerState!
                                    .list[index]
                                    .occupation_controller
                                    .text
                              ));
                            }
                          },
                          child: Container(
                            height: 45,
                            width: DeviceInfo(context).width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: const Alignment(0.8, 1),
                                colors: [
                                  MyTheme.gradient_color_1,
                                  MyTheme.gradient_color_2,
                                ],
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                            child: Center(
                              child: state.manageProfileCombineState!
                                          .careerState!.update_changes! &&
                                      state.manageProfileCombineState!
                                              .careerState!.index ==
                                          index
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: MyTheme.storm_grey,
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .save_change_btn_text,
                                      style: Styles.bold_white_14,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildTitle(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.manage_profile_career_title,
              style: Styles.bold_app_accent_14,
            ),
            IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  OneContext().showDialog<void>(
                    builder: (context) {
                      bool isJob = true;
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add New Career Info",
                              style: Styles.bold_arsenic_14,
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        content: StatefulBuilder(
                          builder: (context,setState) {
                            return SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Divider(
                                    color: MyTheme.storm_grey,
                                    thickness: 1,
                                  ),
                                  GroupItemWithChild(
                                    title: AppLocalizations.of(context)!
                                        .occupation,
                                    style: Styles.bold_arsenic_12,
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: Occupation.Job,
                                          groupValue: state.manageProfileCombineState!.careerState!.occupation,
                                          onChanged: (value) {
                                            setState(() {
                                              isJob =true;
                                              state.manageProfileCombineState!.careerState!.occupation = value!;
                                            });
                                          },
                                        ),
                                        Text(AppLocalizations.of(context)!.job),
                                        Const.width5,
                                        Radio(
                                          value: Occupation.Business,
                                          groupValue: state.manageProfileCombineState!.careerState!.occupation,
                                          onChanged: (value) {
                                            setState(() {
                                              isJob =false;
                                              state.manageProfileCombineState!.careerState!.occupation = value!;
                                            });
                                          },
                                        ),
                                        Text(AppLocalizations.of(context)!.business)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if(isJob)
                                  GroupItemWithChild(
                                    title: AppLocalizations.of(context)!
                                        .type,
                                    style: Styles.bold_arsenic_12,
                                    child: DropdownButtonFormField<dynamic>(
                                      isExpanded: true,
                                      iconSize: 0.0,
                                      decoration: InputDecoration(
                                        hintText: "Select one",
                                        isDense: true,
                                        hintStyle: Styles.regular_gull_grey_12,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: MyTheme.gull_grey,
                                        ),
                                      ),
                                      value: state.manageProfileCombineState!.careerState!
                                          .job_type_value,
                                      items: buildDropdownItems(state.manageProfileCombineState!
                                          .profiledropdownResponseData!.data!.jobTypeList!),
                                      onChanged: (dynamic newValue) {
                                        jobType = newValue;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if(!isJob)
                                  GroupItemWithChild(
                                    title: AppLocalizations.of(context)!
                                        .business_type,
                                    style: Styles.bold_arsenic_12,
                                    child: Row(
                                      children: [
                                        Radio(
                                          value: BusinessType.Private,
                                          groupValue: state.manageProfileCombineState!.careerState!.businessType,
                                          onChanged: (value) {
                                            setState(() {
                                              state.manageProfileCombineState!.careerState!.businessType = value!;
                                            });
                                          },
                                        ),
                                        Text(AppLocalizations.of(context)!.private),
                                        Const.width5,
                                        Radio(
                                          value: BusinessType.Partnership,
                                          groupValue: state.manageProfileCombineState!.careerState!.businessType,
                                          onChanged: (value) {
                                            setState(() {
                                              state.manageProfileCombineState!.careerState!.businessType = value!;
                                            });
                                          },
                                        ),
                                        Text(AppLocalizations.of(context)!.partnership)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10
                                  ),
                                  GroupItemWithChild(
                                    title: AppLocalizations.of(context)!
                                        .monthly_income,
                                    style: Styles.bold_arsenic_12,
                                    child: DropdownButtonFormField<dynamic>(
                                      isExpanded: true,
                                      iconSize: 0.0,
                                      decoration: InputDecoration(
                                        hintText: "Select one",
                                        isDense: true,
                                        hintStyle: Styles.regular_gull_grey_12,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: MyTheme.gull_grey,
                                        ),
                                      ),
                                      value: state.manageProfileCombineState!.careerState!
                                          .income_list_value,
                                      items: state.manageProfileCombineState!
                                          .profiledropdownResponseData!.data!.incomeList!
                                          .map<DropdownMenuItem<dynamic>>((e) {
                                        return DropdownMenuItem<dynamic>(
                                          value: e,
                                          child: Text(
                                            e.value,
                                            style: Styles.regular_arsenic_14,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (dynamic newValue) {
                                        monthlyIncome = newValue;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10
                                  ),
                                  BasicFormWidget(
                                    text: AppLocalizations.of(context)!
                                        .manage_profile_designation,
                                    hint: "Cardiologist",
                                    controller: _designationController,
                                    style: Styles.bold_arsenic_12,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BasicFormWidget(
                                    text: AppLocalizations.of(context)!
                                        .manage_profile_company,
                                    hint: "BlueBerry Hospital",
                                    controller: _companyController,
                                    style: Styles.bold_arsenic_12,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BasicFormWidget(
                                    text: AppLocalizations.of(context)!
                                        .manage_profile_start,
                                    hint: "Start",
                                    controller: _startController,
                                    style: Styles.bold_arsenic_12,
                                    keyboard_type: TextInputType.number,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BasicFormWidget(
                                    text: AppLocalizations.of(context)!
                                        .manage_profile_end,
                                    hint: "End",
                                    controller: _endController,
                                    style: Styles.bold_arsenic_12,
                                    keyboard_type: TextInputType.number,
                                  ),
                                ],
                              ),
                            );
                          }
                        ),
                        actions: [
                          TextButton(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: const Alignment(0.8, 1),
                                  colors: [
                                    MyTheme.gradient_color_1,
                                    MyTheme.gradient_color_2,
                                  ],
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                              ),
                              child: Center(
                                child: store.state.manageProfileCombineState!
                                            .careerState!.saveChanges !=
                                        false
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: MyTheme.storm_grey,
                                        ),
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!
                                            .save_change_btn_text,
                                        style: Styles.bold_white_14,
                                      ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (!_formKey.currentState!.validate()) {
                                // store.dispatch(ShowMessageAction(
                                //   msg: "Form's not validated!",
                                // ));
                              } else {
                                store.dispatch(
                                  careerCreateMiddleware(
                                    designation: _designationController.text,
                                    company: _companyController.text,
                                    start: _startController.text,
                                    end: _endController.text,
                                    type: jobType,
                                    occupation: occupation.name,
                                    businessType: isJob ? null : businessType.name,
                                    monthlyIncome: monthlyIncome.value
                                  ),
                                );

                                _designationController.clear();
                                _companyController.clear();
                                _startController.clear();
                                _endController.clear();
                                occupation = Occupation.Job;
                                businessType = BusinessType.Private;
                                jobType = null;
                                monthlyIncome = null;
                              }
                            },
                          )
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
