import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/utils/string_methods.dart';

class DailyRevenueBox extends StatefulWidget {
  final double revenue;
  const DailyRevenueBox({super.key, required this.revenue});

  @override
  State<DailyRevenueBox> createState() => _DailyRevenueBoxState();
}

class _DailyRevenueBoxState extends State<DailyRevenueBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formatLargeNumber(widget.revenue.toString()),
          style: const TextStyle(
              fontSize: 50, fontWeight: FontWeight.w900, color: redColor),
        ),
      ],
    );
  }
}
