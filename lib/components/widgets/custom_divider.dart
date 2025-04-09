import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  const CustomDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.2,
      color: color ?? textColor1,
    );
  }
}
