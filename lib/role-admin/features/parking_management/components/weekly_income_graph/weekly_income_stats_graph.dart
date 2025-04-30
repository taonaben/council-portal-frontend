import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/role-admin/features/parking_management/components/weekly_income_graph/bar_data.dart';

List<double> weeklyIncomeData = List.generate(
  7,
  (index) => 200 + Random().nextInt(301).toDouble(),
);

class WeeklyIncomeStatsGraph extends StatelessWidget {
  const WeeklyIncomeStatsGraph({super.key});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklyIncomeData[0],
      monAmount: weeklyIncomeData[1],
      tueAmount: weeklyIncomeData[2],
      wedAmount: weeklyIncomeData[3],
      thuAmount: weeklyIncomeData[4],
      friAmount: weeklyIncomeData[5],
      satAmount: weeklyIncomeData[6],
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: weeklyIncomeData.reduce(max) + 20,
        minY: 0,
        groupsSpace: 12,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            direction: TooltipDirection.auto,
            tooltipRoundedRadius: 8,

            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.round().toString(),
                const TextStyle(color: textColor1, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomTitleWidgets,
              ),
            )),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: primaryColor,
                      width: 14,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: weeklyIncomeData.reduce(max) + 20,
                        color: secondaryColor,
                      ))
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: textColor1,
      // fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('S', style: style);
        break;
      case 1:
        text = const Text('M', style: style);
        break;
      case 2:
        text = const Text('T', style: style);
        break;
      case 3:
        text = const Text('W', style: style);
        break;
      case 4:
        text = const Text('T', style: style);
        break;
      case 5:
        text = const Text('F', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      meta: meta,
      child: text,
    );
  }
}
