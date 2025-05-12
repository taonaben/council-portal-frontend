import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';

class CustomTextfield extends StatefulWidget {
  final String? hintText;
  final String labelText;
  final Color? labelTextColor;
  final String? helperText;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function(String)? onSubmit;
  final bool? obscureText;

  const CustomTextfield({
    super.key,
    this.maxLines,
    this.helperText,
    this.hintText,
    required this.labelText,
    this.labelTextColor,
    this.textInputType,
    this.maxLength,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.validator,
    this.suffixIcon,
    this.onSubmit,
    this.obscureText,
  });

  @override
  _CustomTextfieldState createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _isHelperVisible = false;
  String? _errorText;

  void _toggleHelperText() {
    setState(() {
      _isHelperVisible = !_isHelperVisible;
    });
  }

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
          TextFormField(
            validator: (value) {
              String? result = widget.validator?.call(value);
              setState(() {
                _errorText = result;
              });
              return null;
            },
            onFieldSubmitted: widget.onSubmit,
            maxLines: widget.maxLines ?? 1,
            keyboardType: widget.textInputType,
            obscureText: widget.obscureText ?? false,
            controller: widget.controller,
            maxLength: widget.maxLength,
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            inputFormatters: widget.textInputType == TextInputType.number
                ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))]
                : null,
            style: TextStyle(color: widget.labelTextColor ?? textColor1),
            decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: secondaryColor, fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(uniBorderRadius),
                  borderSide: const BorderSide(color: secondaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(uniBorderRadius),
                  borderSide: const BorderSide(color: secondaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(uniBorderRadius),
                  borderSide: const BorderSide(color: primaryColor),
                ),
                suffixIcon: widget.suffixIcon),
          ),
          if (_isHelperVisible && widget.helperText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.helperText!,
                style: const TextStyle(color: textColor2),
              ),
            ),
          if (_errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                _errorText!,
                style: const TextStyle(
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
