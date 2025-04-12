import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color color;
  final Color? backgroundColor;
  const CustomCircularProgressIndicator(
      {super.key, required this.color, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        strokeCap: StrokeCap.round,
        backgroundColor: backgroundColor ?? Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
