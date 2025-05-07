import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/parking/tickets/model/ticket_bundle_model.dart';
import 'package:portal/features/parking/tickets/provider/parking_ticket_provider.dart';
import 'package:portal/features/parking/tickets/provider/ticket_bundle_provider.dart';
import 'package:portal/features/parking/tickets/services/ticket_bundle_services.dart';

class MyBundlesPage extends ConsumerWidget {
  final String vehicleId;
  const MyBundlesPage({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allBundlesAsyncValue = ref.watch(allBundlesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bundles'),
        centerTitle: true,
        backgroundColor: background1,
      ),
      body: Column(
        children: [
          Expanded(
            child: allBundlesAsyncValue.when(
              data: (bundles) {
                return ListView.builder(
                  itemCount: bundles.length,
                  itemBuilder: (context, index) {
                    final bundle = bundles[index];
                    return buildBundleCard(bundle);
                  },
                );
              },
              loading: () => const Center(
                  child: CustomCircularProgressIndicator(color: textColor2)),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomFilledButton(
              btnLabel: "Activate ticket",
              onTap: () async {
                var bundleServices = TicketBundleServices();

                try {
                  var city = await getSP("city").then((value) {
                    if (value.isEmpty) {
                      throw Exception(
                          "City ID not found in shared preferences");
                    }
                  });

                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                            child: CustomCircularProgressIndicator(
                                color: textColor2),
                          ));

                  var result =
                      await bundleServices.redeemTicketFromBundle(vehicleId);

                  if (result) {
                    Navigator.pop(context);
                    const CustomSnackbar(
                            message: "Ticket activated successfully",
                            color: primaryColor)
                        .showSnackBar(context);

                    ref.refresh(allBundlesProvider);
                    ref.refresh(activeTicketProvider);
                    ref.refresh(allTicketsProvider);

                    context.pushReplacement(
                      '/home/1',
                    );
                  } else {
                    Navigator.pop(context);
                    const CustomSnackbar(
                            message: "Error activating ticket", color: redColor)
                        .showSnackBar(context);
                  }
                } catch (e) {
                  DevLogs.logError("Error $e");
                  CustomSnackbar(message: "Error $e", color: redColor)
                      .showSnackBar(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBundleCard(TicketBundleModel bundle) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uniBorderRadius)),
      elevation: 3,
      color: background1,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shadowColor: blackColor.withOpacity(.5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Remaining Tickets",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                Text(bundle.remaining_tickets.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const Gap(8),
            const CustomDivider(color: textColor2),
            const Gap(8),
            buildRow(
              title: 'Bundle Amount',
              value: "USD\$${bundle.price_paid}",
            ),
            const Gap(8),
            buildRow(
              title: 'Bundle Tickets',
              value: bundle.quantity.toString(),
            ),
            const Gap(8),
            buildRow(
              title: 'Tickets Used',
              value: bundle.tickets_redeemed.toString(),
            ),
            const Gap(8),
            buildRow(
              title: 'Purchase Date',
              value: dateFormatted(bundle.purchased_at),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
        ),
        Text(
          value,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
