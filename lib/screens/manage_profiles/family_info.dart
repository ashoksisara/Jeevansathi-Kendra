import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_input.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/redux/libs/manage_profile/manage_profiles_state/family_state.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/basic_form_widget.dart';
import '../../redux/libs/manage_profile/manage_profile_reducer/family_reducer.dart';

class FamilyInformation extends StatefulWidget {
  const FamilyInformation({Key? key}) : super(key: key);

  @override
  State<FamilyInformation> createState() => _FamilyInformationState();
}

class _FamilyInformationState extends State<FamilyInformation> {
  List<String> occupationList = ["Job", "Business", "Student", "Other"];
  String maritalStatus = "Unmarried";

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.manage_profile_family_info,
        ).build(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Const.kPaddingHorizontal,
                  vertical: Const.kPaddingVertical),
              child: Form(
                key: state.manageProfileCombineState!.familyState!.formKey,
                child: buildBody(context, state),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_your_family_info,
          style: Styles.bold_app_accent_14,
        ),
        const SizedBox(
          height: 15,
        ),
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_father,
          child: TextFormField(
            controller:
                state.manageProfileCombineState!.familyState!.fatherController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputStyle.inputDecoration_text_field(hint: "Father"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_father_education,
          child: TextFormField(
            controller: state.manageProfileCombineState!.familyState!
                .fatherEducationController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration:
                InputStyle.inputDecoration_text_field(hint: "Father education"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_father_occupation,
          child: TextFormField(
            controller: state.manageProfileCombineState!.familyState!
                .fatherOccupationController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputStyle.inputDecoration_text_field(
                hint: "Father occupation"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_father_status,
          style: Styles.bold_arsenic_12,
          child: Row(
            children: [
              Radio(
                value: AliveStatus.Alive,
                groupValue:
                    state.manageProfileCombineState!.familyState!.fatherStatus,
                onChanged: (value) {
                  setState(() {
                    state.manageProfileCombineState!.familyState!.fatherStatus =
                        value!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.alive),
              Const.width5,
              Radio(
                value: AliveStatus.Deceased,
                groupValue:
                    state.manageProfileCombineState!.familyState!.fatherStatus,
                onChanged: (value) {
                  setState(() {
                    state.manageProfileCombineState!.familyState!.fatherStatus =
                        value!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.deceased)
            ],
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_mother,
          child: TextFormField(
            controller:
                state.manageProfileCombineState!.familyState!.motherController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputStyle.inputDecoration_text_field(hint: "Mother"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_mother_education,
          child: TextFormField(
            controller: state.manageProfileCombineState!.familyState!
                .motherEducationController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration:
                InputStyle.inputDecoration_text_field(hint: "Mother education"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_mother_occupation,
          child: TextFormField(
            controller: state.manageProfileCombineState!.familyState!
                .motherOccupationController!,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "This field is required";
              }
              return null;
            },
            decoration: InputStyle.inputDecoration_text_field(
                hint: "Mother occupation"),
          ),
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_mother_status,
          style: Styles.bold_arsenic_12,
          child: Row(
            children: [
              Radio(
                value: AliveStatus.Alive,
                groupValue:
                    state.manageProfileCombineState!.familyState!.motherStatus,
                onChanged: (value) {
                  setState(() {
                    state.manageProfileCombineState!.familyState!.motherStatus =
                        value!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.alive),
              Const.width5,
              Radio(
                value: AliveStatus.Deceased,
                groupValue:
                    state.manageProfileCombineState!.familyState!.motherStatus,
                onChanged: (value) {
                  setState(() {
                    state.manageProfileCombineState!.familyState!.motherStatus =
                        value!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.deceased)
            ],
          ),
        ),
        Const.height20,
        _buildSibling(context, state),
        Const.height20,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.manageProfileCombineState!.familyState!.siblingList.length,
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
                              AppLocalizations.of(context)!.public_profile_name,
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
                                        .familyState!
                                        .siblingList[index]
                                        .name),
                                controller: state
                                    .manageProfileCombineState!
                                    .familyState!
                                    .siblingList[index]
                                    .nameController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GroupItemWithChild(
                        title: AppLocalizations.of(context)!.relation,
                        style: Styles.bold_arsenic_12,
                        child: Row(
                          children: [
                            Radio<SiblingType>(
                              value: SiblingType.Brother,
                              groupValue: state
                                  .manageProfileCombineState!
                                  .familyState!
                                  .siblingType,
                              onChanged: (value) {
                                  state
                                      .manageProfileCombineState!
                                      .familyState!
                                      .siblingList[index]
                                      .type = value!;
                              },
                            ),
                            Text(AppLocalizations.of(context)!.brother),
                            Const.width5,
                            Radio<SiblingType>(
                              value: SiblingType.Sister,
                              groupValue: state
                                  .manageProfileCombineState!
                                  .familyState!
                                  .siblingType,
                              onChanged: (value) {
                                  state
                                      .manageProfileCombineState!
                                      .familyState!
                                      .siblingList[index]
                                      .type = value!;
                              },
                            ),
                            Text(AppLocalizations.of(context)!.sister)
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
                                  .manage_profile_education_Info,
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
                                        .familyState!
                                        .siblingList[index]
                                        .education),
                                controller: state
                                    .manageProfileCombineState!
                                    .familyState!
                                    .siblingList[index]
                                    .educationController,
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
                                  .occupation,
                              style: Styles.bold_arsenic_12,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButtonFormField<String>(
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
                                  .familyState!
                                  .siblingList[index].occupation,
                              items: occupationList
                                  .map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: Styles.regular_arsenic_14,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                state
                                    .manageProfileCombineState!
                                    .familyState!
                                    .siblingList[index].occupation = newValue;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GroupItemWithChild(
                    title: AppLocalizations.of(context)!.manage_profile_marital_status,
                    style: Styles.bold_arsenic_12,
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Unmarried",
                          groupValue: maritalStatus,
                          onChanged: (value) {
                            state
                                .manageProfileCombineState!
                                .familyState!
                                .siblingList[index]
                                .maritalStatus = value!;
                          },
                        ),
                        Text(AppLocalizations.of(context)!.unmarried),
                        Const.width5,
                        Radio<String>(
                          value: "Married",
                          groupValue: maritalStatus,
                          onChanged: (value) {
                            state
                                .manageProfileCombineState!
                                .familyState!
                                .siblingList[index]
                                .maritalStatus = value!;
                          },
                        ),
                        Text(AppLocalizations.of(context)!.married)
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Const.height40,
        InkWell(
          onTap: () => store.dispatch(UpdateInfo.family),
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
              child: state.manageProfileCombineState!.familyState!.pageloader ==
                      false
                  ? Text(
                      AppLocalizations.of(context)!.save_change_btn_text,
                      style: Styles.bold_white_14,
                    )
                  : CommonWidget.circularIndicator,
            ),
          ),
        ),
      ],
    );
  }

  _buildSibling(context, AppState state) {
    final nameController = TextEditingController();
    final educationController = TextEditingController();
    String maritalStatus = "Unmarried";
    SiblingType siblingType = SiblingType.Brother;
    String? selectedOccupation;
    final formKey = GlobalKey<FormState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.manage_profile_sibling,
          style: Styles.bold_app_accent_14,
        ),
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () async {
              OneContext().showDialog(
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add New Sibling Info",
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
                    content: StatefulBuilder(builder: (context, setState) {
                      return Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(
                                color: MyTheme.storm_grey,
                                thickness: 1,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .public_profile_name,
                                hint: "Name",
                                controller: nameController,
                                style: Styles.bold_arsenic_12,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter name";
                                  }
                                  return null;
                                },
                              ),
                              GroupItemWithChild(
                                title: AppLocalizations.of(context)!.relation,
                                style: Styles.bold_arsenic_12,
                                child: Row(
                                  children: [
                                    Radio<SiblingType>(
                                      value: SiblingType.Brother,
                                      groupValue: siblingType,
                                      onChanged: (value) {
                                        setState(() {
                                          siblingType = value!;
                                        });
                                      },
                                    ),
                                    Text(AppLocalizations.of(context)!.brother),
                                    Const.width5,
                                    Radio<SiblingType>(
                                      value: SiblingType.Sister,
                                      groupValue: siblingType,
                                      onChanged: (value) {
                                        setState(() {
                                          siblingType = value!;
                                        });
                                      },
                                    ),
                                    Text(AppLocalizations.of(context)!.sister)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BasicFormWidget(
                                text: AppLocalizations.of(context)!
                                    .manage_profile_education_Info,
                                hint: "Education",
                                controller: educationController,
                                style: Styles.bold_arsenic_12,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter education";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              GroupItemWithChild(
                                title: AppLocalizations.of(context)!.occupation,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Select occupation";
                                    }
                                    return null;
                                  },
                                  value: selectedOccupation,
                                  items: occupationList
                                      .map<DropdownMenuItem<String>>((e) {
                                    return DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: Styles.regular_arsenic_14,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic newValue) {
                                    selectedOccupation = newValue;
                                    setState(() {});
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GroupItemWithChild(
                                title: AppLocalizations.of(context)!
                                    .advanced_search_screen_marital_status,
                                style: Styles.bold_arsenic_12,
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: "Unmarried",
                                      groupValue: maritalStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          maritalStatus = value!;
                                        });
                                      },
                                    ),
                                    Text(AppLocalizations.of(context)!.unmarried),
                                    Const.width5,
                                    Radio<String>(
                                      value: "Married",
                                      groupValue: maritalStatus,
                                      onChanged: (value) {
                                        setState(() {
                                          maritalStatus = value!;
                                        });
                                      },
                                    ),
                                    Text(AppLocalizations.of(context)!.married)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
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
                            child: Text(
                              AppLocalizations.of(context)!
                                  .save_change_btn_text,
                              style: Styles.bold_white_14,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                          } else {
                            store.dispatch(SaveChanges.familyInfo);
                            final sibling = SiblingModel(
                                occupation: selectedOccupation,
                                type: siblingType.name,
                                name: nameController.text,
                                education: educationController.text,
                                maritalStatus: maritalStatus);
                            state.manageProfileCombineState!.familyState!
                                .siblingList
                                .add(sibling);
                            Navigator.of(context).pop(true);
                            store.dispatch(SaveChanges.familyInfo);
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
    );
  }
}
