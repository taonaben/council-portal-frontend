import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/water/components/water_bill.dart';
import 'package:portal/features/water/model/water_bill_model.dart';
import 'package:portal/features/water/providers/water_billing_provider.dart';
import 'package:intl/intl.dart';

class AccountWaterBillsHistoryPage extends ConsumerStatefulWidget {
  final int accountId; 
  const AccountWaterBillsHistoryPage({super.key, required this.accountId});

  @override
  ConsumerState<AccountWaterBillsHistoryPage> createState() =>
      _AccountWaterBillsHistoryPageState();
}

class _AccountWaterBillsHistoryPageState
    extends ConsumerState<AccountWaterBillsHistoryPage> {
  final Set<String> _expandedBills = {};

  void _toggleExpanded(String? billId) {
    if (billId == null) return;

    setState(() {
      if (_expandedBills.contains(billId)) {
        _expandedBills.remove(billId);
      } else {
        _expandedBills.add(billId);
      }
    });
  }

  @override
  
  Widget build(BuildContext context) {
    final allBillsAsyncValue =
        ref.watch(accountWaterBillsProvider(widget.accountId));

    return allBillsAsyncValue.when(
      data: (waterBills) {
        return Scaffold(
          body: waterBills.isEmpty
              ? const Center(child: Text("No water bills found"))
              : ListView.builder(
                  itemCount: waterBills.length,
                  itemBuilder: (context, index) {
                    final waterBill = waterBills[index];
                    final isExpanded = _expandedBills.contains(waterBill.id);
                    return buildBill(waterBill, isExpanded);
                  },
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

  Widget buildBill(WaterBillModel waterBill, bool isExpanded) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final billDate = waterBill.created_at != null
        ? dateFormatted(waterBill.created_at!)
        : 'N/A';

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uniBorderRadius),
          side: const BorderSide(
            color: textColor2,
            width: 1,
          )),
      elevation: 3,
      color: background1,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shadowColor: blackColor.withOpacity(.6),
      child: InkWell(
        borderRadius: BorderRadius.circular(uniBorderRadius),
        onTap: () => _toggleExpanded(waterBill.id),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Always visible summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bill #${waterBill.bill_number ?? 'N/A'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          'Date: $billDate',
                          style: const TextStyle(
                            color: secondaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatter.format(waterBill.total_amount ?? 0),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: waterBill.payment_status == 'PAID'
                              ? primaryColor.withOpacity(0.2)
                              : redColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          waterBill.payment_status ?? 'PENDING',
                          style: TextStyle(
                            color: waterBill.payment_status == 'PAID'
                                ? primaryColor
                                : redColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Expandable section
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: isExpanded
                    ? Column(
                        children: [
                          const Divider(height: 24),
                          WaterBill(waterBill: waterBill),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              // Show hint to expand/collapse
              Center(
                child: Icon(
                  isExpanded
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
