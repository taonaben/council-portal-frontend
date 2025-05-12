import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portal/constants/colors.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  const CustomCheckbox({super.key, required this.value});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.value,
      activeColor: primaryColor,
      checkColor: textColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: const BorderSide(
        color: textColor1,
        width: 1.5,
      ),
      onChanged: (value) {
        setState(() {
          value = value!;
        });
      },
    );
  }
}
