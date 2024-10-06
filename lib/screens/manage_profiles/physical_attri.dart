import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/common_app_bar_manageprofile.dart';
import 'package:active_matrimonial_flutter_app/components/common_widget.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/const/const.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/screens/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhysicalAtrributes extends StatefulWidget {
  const PhysicalAtrributes({Key? key}) : super(key: key);

  @override
  State<PhysicalAtrributes> createState() => _PhysicalAtrributesState();
}

class _PhysicalAtrributesState extends State<PhysicalAtrributes> {

  bool isDisable = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) => Scaffold(
        appBar: CommonAppBarManageProfile(
          text: AppLocalizations.of(context)!.public_profile_physical_attri,
        ).build(context),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Const.kPaddingHorizontal,
                vertical: Const.kPaddingVertical),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: state
                        .manageProfileCombineState!.physicalAttrState!.formKey,
                    child: Column(
                      children: [
                        buildBody(context, state),
                      ],
                    ),
                  )
                ],
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
          AppLocalizations.of(context)!.manage_profile_physical_attri,
          style: Styles.bold_app_accent_14,
        ),
        Const.height25,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_height,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MyTheme.solitude),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            child: DropdownButtonFormField(
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
              value: state.manageProfileCombineState!.physicalAttrState!
                  .height,
              items: state.manageProfileCombineState!
                  .profiledropdownResponseData!.data!.heightList!
                  .map<DropdownMenuItem>((e) {
                return DropdownMenuItem(
                  value: e.key,
                  child: Text(
                    e.value,
                    style: Styles.regular_arsenic_14,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                state.manageProfileCombineState!.physicalAttrState!
                    .height = newValue;
              },
            ),
          ),
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_weight,
          style: Styles.bold_arsenic_12,
          keyboard_type: TextInputType.number,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.weightController,
          hint: "112.6 pounds (51.2 kilograms",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter weight";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_eye_color,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.eyeColorController,
          hint: "Blue",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter eye color";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_hair_color,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.physicalAttrState!
              .hairColorController,
          hint: "Black",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter hair color";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_complexion,
          style: Styles.bold_arsenic_12,
          controller: state.manageProfileCombineState!.physicalAttrState!
              .complexionController,
          hint: "Olive skin",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter complexion";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_body_type,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.bodyTypeController,
          hint: "Medium",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter body type";
            }
            return null;
          },
        ),
        Const.height20,
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_body_art,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.bodyArtController,
          hint: "Body piercing",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter body art";
            }
            return null;
          },
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_disability,
          style: Styles.bold_arsenic_12,
          child: Row(
            children: [
              Radio(
                value: Disability.No,
                groupValue: state.manageProfileCombineState!.physicalAttrState!.disability,
                onChanged: (value) {
                  setState(() {
                    isDisable = false;
                    state.manageProfileCombineState!.physicalAttrState!.disability = value!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.no),
              Const.width5,
              Radio(
                value: Disability.Yes,
                groupValue: state.manageProfileCombineState!.physicalAttrState!.disability,
                onChanged: (value) {
                  setState(() {
                    isDisable = true;
                    state.manageProfileCombineState!.physicalAttrState!.disability = value!;
                  });
                },
              ),
              Text(AppLocalizations.of(context)!.yes)
            ],
          ),
        ),
        if(isDisable)
        Const.height20,
        if(isDisable)
        BasicFormWidget(
          text: AppLocalizations.of(context)!.manage_profile_disability_details,
          style: Styles.bold_arsenic_12,
          controller: state
              .manageProfileCombineState!.physicalAttrState!.disabilityController,
          hint: "Disability Details",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter disability details";
            }
            return null;
          },
        ),
        Const.height20,
        GroupItemWithChild(
          title: AppLocalizations.of(context)!.manage_profile_blood_group,
          style: Styles.bold_arsenic_12,
          child:  DropdownButtonFormField<dynamic>(
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
                .physicalAttrState!.bloodGroup,
            items: state.manageProfileCombineState!
                .profiledropdownResponseData!.data!.bloodGroupList!.map((e) => e.value).toList()
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
                  .physicalAttrState!.bloodGroup = newValue;
            },
          ),
        ),
        Const.height40,
        InkWell(
          onTap: () => store.dispatch(UpdateInfo.physicalAttr),
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
              child: state.manageProfileCombineState!.physicalAttrState!
                          .isLoading ==
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
}
