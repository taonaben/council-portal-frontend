import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/features/water/components/water_bill.dart';
import 'package:portal/features/water/providers/water_billing_provider.dart';

class AccountWaterBillsHistoryPage extends ConsumerWidget {
  final int accountId;
  const AccountWaterBillsHistoryPage({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allBillsAsyncValue = ref.watch(accountWaterBillsProvider(accountId));

    return allBillsAsyncValue.when(data: (waterBills) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Water Bills History"),
          centerTitle: true,
        ),
        body: waterBills.isEmpty
            ? const Center(child: Text("No water bills found"))
            : ListView.builder(
                itemCount: waterBills.length,
                itemBuilder: (context, index) {
                  final waterBill = waterBills[index];
                  return WaterBill(waterBill: waterBill);
                },
              ),
      );
    }, error: (error, stackTrace) {
      const CustomSnackbar(message: "Error", color: redColor)
          .showSnackBar(context);
      return Center(
        child: Text("Error: $error"),
      );
    }, loading: () {
      return const Center(
          child: CustomCircularProgressIndicator(color: textColor2));
    });
  }
}
