import 'package:active_matrimonial_flutter_app/components/basic_form_widget.dart';
import 'package:active_matrimonial_flutter_app/components/group_item_with_child.dart';
import 'package:active_matrimonial_flutter_app/const/my_theme.dart';
import 'package:active_matrimonial_flutter_app/const/style.dart';
import 'package:active_matrimonial_flutter_app/helpers/device_info.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/ddown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';

import 'common_input.dart';

class CommonWidget {
  static InkWell social_button({
    String? text,
    Gradient? gradient,
    String? icon,
    double width = 36,
    double height = 36,
    double radius = 12,
    // Color color = const Color.fromRGBO(255, 255, 255, 0.0),
    Color? color,
    Function? onpressed,
    double opacity = 1.0,
  }) {
    return InkWell(
      onTap: onpressed as void Function()?,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color != null ? color.withOpacity(opacity) : null,
          gradient: color == null ? gradient : null,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
            child: IconButton(
          icon: Image.asset(
            'assets/icon/${icon}',
            width: 16,
            height: 16,
          ),
          onPressed: null,
          // color: MyTheme.white,
        )
            // child: icon,
            ),
      ),
    );
  }

  // custom input field combined

  static Widget manage_profile_update_box({required context, text}) {
    return Container(
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
        child: Text(
          AppLocalizations.of(context)!.save_change_btn_text,
          style: Styles.bold_white_14,
        ),
      ),
    );
  }

  DropdownButtonFormField<DDown> buildDropdownButtonFormField(
      List<DDown> list, dynamic f,
      {dynamic value}) {
    return DropdownButtonFormField<DDown>(
      value: value,
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
      items: list.map<DropdownMenuItem<DDown>>((e) {
        return DropdownMenuItem<DDown>(
          value: e,
          child: Text(
            e.name!,
            style: Styles.regular_gull_grey_12.copyWith(color: MyTheme.black),
          ),
        );
      }).toList(),
      onChanged: (DDown? newValue) {
        f(newValue);
      },
    );
  }

  DropdownButtonFormField<DDown> buildCommonDropDown(
      List<DDown> list, DDown? value, dynamic onchange) {
    return DropdownButtonFormField<DDown>(
      value: value,
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
        if (value == null || value.id == null) {
          return "Field required";
        }
        return null;
      },
      items: list.map<DropdownMenuItem<DDown>>((e) {
        return DropdownMenuItem<DDown>(
          value: e,
          child: Text(
            e.name!,
            style: Styles.regular_gull_grey_12.copyWith(color: MyTheme.black),
          ),
        );
      }).toList(),
      onChanged: (DDown? newValue) {
        onchange(newValue);
      },
    );
  }

  static BoxShadow box_shadow() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 10,
      offset: const Offset(0, 5.0), // changes position of shadow
    );
  }

  static Widget noData = Center(
    child: Text(AppLocalizations.of(OneContext().context!)!.common_no_data),
  );

  static Widget noMoreData = const Center(
    child: Text("No more data"),
  );

  static Widget circularIndicator = Center(
    child: CircularProgressIndicator(
      color: MyTheme.storm_grey,
    ),
  );

  static Widget divider = Divider(
    thickness: 1,
    color: Colors.white.withOpacity(0.50),
  );

  static Widget dialogCrossBtn = IconButton(
    padding: EdgeInsets.zero,
    constraints: const BoxConstraints(),
    onPressed: () => OneContext().popDialog(),
    icon: Image.asset(
      'assets/icon/icon_cross.png',
      height: 16,
      width: 16,
    ),
  );
}

class MultiSelectDropdown extends StatefulWidget {
  final String title;
  final List<DDown> items; // List of selectable items
  final List<DDown> selectedItems; // Selected items
  final Function(List<DDown>)
      onSelectionChanged; // Callback when selection changes

  const MultiSelectDropdown({
    Key? key,
    required this.items,
    required this.title,
    required this.selectedItems,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<DDown> _selectedItems = [];
  final countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(
        widget.selectedItems);
    countryController.text = _selectedItems.map((e) => e.name).join(", ");
  }

  // This function will be called when the user confirms the selection
  void _showMultiSelectDialog(BuildContext context) async {
    final List<DDown> tempSelected = List.from(_selectedItems);

    // Show dialog to select items
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Contry"),
          content: StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: widget.items.map((item) {
                  return CheckboxListTile(
                    value: tempSelected.contains(item),
                    activeColor: MyTheme.app_accent_color,
                    title: Text(item.name ?? ''),
                    onChanged: (bool? selected) {
                      setState(() {
                        if (selected == true) {
                          tempSelected.add(item);
                        } else {
                          tempSelected.remove(item);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            );
          }),
          actions: <Widget>[
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
                    AppLocalizations.of(context)!.save_change_btn_text,
                    style: Styles.bold_white_14,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedItems = tempSelected;
                  widget.onSelectionChanged(_selectedItems); // Call callback
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    countryController.text = _selectedItems.map((e) => e.name).join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Styles.bold_arsenic_12,
        ),
        TextFormField(
          readOnly: true,
          onTap: () {
            _showMultiSelectDialog(context);
          },
          controller: countryController,
          decoration: InputStyle.inputDecoration_text_field(
              suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined)),
        )
      ],
    );
  }
}
