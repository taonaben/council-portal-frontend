import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.2,
      color: textColor1,
    );
  }
}
