import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/role-admin/features/parking_management/components/daily_income_graph/income_points.dart';

class DailyIncomeStatsGraph extends StatelessWidget {
  final List<IncomePoints> incomePoints;
  final List<int> operatingHours =
      List.generate(10, (index) => index + 8); // 8 AM - 6 PM

  DailyIncomeStatsGraph({super.key, required this.incomePoints});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: incomePoints.map((e) => FlSpot(e.x, e.y)).toList(),
              isCurved: false,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
              color: accentColor,
            ),
          ],
          maxY: incomePoints.map((e) => e.y).reduce(max) + 20,
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            enabled: true,
            touchSpotThreshold: 20,
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map((index) {
                return const TouchedSpotIndicatorData(
                  FlLine(color: accentColor, strokeWidth: 2),
                  FlDotData(show: true),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 8,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((touchedSpot) {
                  int hour = operatingHours[touchedSpot.spotIndex];
                  return LineTooltipItem(
                    '$hour:00 \n \$${touchedSpot.y.toStringAsFixed(2)}',
                    const TextStyle(
                      color: textColor1,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  );
                }).toList();
              },
            ),
          ),
          titlesData: const FlTitlesData(
            show: false,
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(
            show: true,
            drawVerticalLine: true,
            verticalInterval: 1,
            drawHorizontalLine: false,
          ),
        ),
      ),
    );
  }
}
