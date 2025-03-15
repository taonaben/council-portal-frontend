import 'dart:math';
import 'package:flutter/material.dart';

class IncomeStatsGraph extends StatelessWidget {
  const IncomeStatsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> graphData = List.generate(
      6,
      (index) => 200 + Random().nextInt(301).toDouble(),
    );
    
    return const Placeholder();
  }
}