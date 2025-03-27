import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';

class CustomFilledButton extends StatelessWidget {
  final String btnLabel;
  final double? widthSize;
  final Function()? onTap;
  const CustomFilledButton(
      {super.key, required this.btnLabel, required this.onTap, this.widthSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // minimumSize: const Size(double.infinity, 50),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        shadowColor: null,
        elevation: 0,
        foregroundColor: textColor2,
        // maximumSize: const Size(double.infinity, 50),
      ),
      onPressed: onTap,
      child: Text(
        btnLabel,
        // style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
