import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/water/providers/water_billing_provider.dart';

class AccountInsightsPage extends ConsumerStatefulWidget {
  final int accountId;
  const AccountInsightsPage({super.key, required this.accountId});

  @override
  ConsumerState<AccountInsightsPage> createState() =>
      _AccountInsightsPageState();
}

class _AccountInsightsPageState extends ConsumerState<AccountInsightsPage> {
  @override
  Widget build(BuildContext context) {
    final allBillsAsyncValue =
        ref.watch(accountWaterBillsProvider(widget.accountId));

    return allBillsAsyncValue.when(
      data: (waterBills) {
        if (waterBills.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No water bills found")),
          );
        }

        // Calculate total debt and ticket count
        final totalDebt = waterBills.fold<double>(
          0,
          (sum, bill) => sum + (bill.water_debt?.total_debt ?? 0),
        );
        final ticketCount = waterBills.length;

        // Prepare data for the line graph
        final lineChartData = waterBills.asMap().entries.map((entry) {
          final index = entry.key;
          final bill = entry.value;
          return FlSpot(index.toDouble(), bill.water_usage?.consumption ?? 0);
        }).toList();

        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total Debt Container
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInsightContainer(
                      title: "Total Debt",
                      value: "${totalDebt.toStringAsFixed(2)} USD",
                    ),

                    // Ticket Count Container
                    buildInsightContainer(
                      title: "Number of Tickets",
                      value: "$ticketCount",
                    ),
                  ],
                ),
                const Gap(16),

                // Line Graph Container
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: background1,
                    border: Border.all(color: textColor2),
                    borderRadius: BorderRadius.circular(uniBorderRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Water Consumption (Bar Graph)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(8),
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 &&
                                        index < waterBills.length) {
                                      final date = DateTime.parse(
                                          waterBills[index].created_at ?? "");
                                      return Text(
                                        "${twoDigits(date.day)}/${twoDigits(date.month)}",
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: textColor2,
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipPadding: EdgeInsets.all(4),
                                tooltipMargin: 0,
                                tooltipRoundedRadius: 4,
                                fitInsideVertically: true,
                                getTooltipColor: (group) => background2,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    "${rod.toY.toStringAsFixed(2)}m³",
                                    const TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              touchCallback: (event, response) {},
                              allowTouchBarBackDraw: true,
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: lineChartData.map((spot) {
                              return BarChartGroupData(
                                x: spot.x.toInt(),
                                barRods: [
                                  BarChartRodData(
                                    toY: spot.y,
                                    color: primaryColor,
                                    width: 16,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        const CustomSnackbar(message: "Error", color: redColor)
            .showSnackBar(context);
        return Center(
          child: Text("Error: $error"),
        );
      },
      loading: () {
        return const Center(
            child: CustomCircularProgressIndicator(color: textColor2));
      },
    );
  }

  Widget buildInsightContainer({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: background1,
        border: Border.all(color: textColor2),
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
