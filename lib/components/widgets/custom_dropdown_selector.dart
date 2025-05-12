import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';

class CustomDropDownSelector extends StatefulWidget {
  final String selectHintText;
  final String? selectedStatus;
  final ValueChanged<String?>? onChanged;
  final List<String> listItems;
  final Color? myColor;
  final String labelText;
  final Color? labelTextColor;

  const CustomDropDownSelector({
    super.key,
    this.selectedStatus,
    this.onChanged,
    required this.selectHintText,
    required this.listItems,
    this.myColor,
    required this.labelText,
    this.labelTextColor,
  });

  @override
  _CustomDropDownSelectorState createState() => _CustomDropDownSelectorState();
}

class _CustomDropDownSelectorState extends State<CustomDropDownSelector> {
  String? _selectedStatus;

  List<String> get statuses => widget.listItems;

  String get selectHintText => widget.selectHintText;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
  }

  bool isEmpty() => _selectedStatus == null || _selectedStatus == '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${capitalize(widget.labelText)}:',
            style: TextStyle(
                color: widget.labelTextColor ?? textColor1,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          const Gap(5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(uniBorderRadius),
              border: Border.all(color: widget.myColor ?? secondaryColor),
            ),
            child: DropdownButton<String>(
              value: _selectedStatus,
              hint: Text(
                capitalize(widget.listItems[0]),
                style: const TextStyle(color: secondaryColor),
              ),
              isExpanded: true,
              items: statuses.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStatus = newValue;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(newValue);
                }
              },
              icon: const Icon(CupertinoIcons.chevron_down,
                  color: secondaryColor),
              style: TextStyle(
                color: widget.myColor ?? secondaryColor,
              ),
              underline: const Gap(0),
              iconSize: 14,
              dropdownColor: textColor2,
              borderRadius: BorderRadius.circular(uniBorderRadius),
              elevation: 3,
            ),
          ),
        ],
      ),
    );
  }
}
