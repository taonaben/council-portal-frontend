import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/accounts/model/account_model.dart';
import 'package:portal/features/cities/providers/cities_providers.dart';
import 'package:portal/features/properties/models/property_model.dart';
import 'package:portal/features/properties/providers/properties_provider.dart';
import 'package:portal/features/water/components/water_bill.dart';
import 'package:portal/features/water/providers/water_billing_provider.dart';

class CurrentBillCard extends ConsumerWidget {
  final AccountModel account;
  CurrentBillCard({super.key, required this.account});

  Future<String> _getUserFullName() async {
    return await getSP("user_full_name") ?? "Unknown User";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: background1,
          border: Border.all(color: background2),
          borderRadius: BorderRadius.circular(uniBorderRadius + 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(ref),
            buildBillDetails(ref),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Widget header(WidgetRef ref) {
    final propertyAsyncValue =
        ref.watch(propertyByIdProvider(account.property));

    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: background2,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(uniBorderRadius),
          topRight: Radius.circular(uniBorderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Current Bill",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: textColor1),
          ),
          const Gap(4),
          FutureBuilder<String>(
            future: _getUserFullName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...",
                    style: TextStyle(color: textColor1));
              }
              return Text(
                snapshot.data ?? "Error loading name",
                style: const TextStyle(color: textColor1),
              );
            },
          ),
          const Gap(4),
          Text("Account Number: ${account.account_number}",
              style: const TextStyle(color: textColor1)),
          const Gap(4),
          propertyAsyncValue.when(
            data: (property) => buildPropertyDetails(ref, property),
            loading: () => const Text('Loading...'),
            error: (error, stack) => const Text('Error fetching property'),
          ),
        ],
      ),
    );
  }

  Widget buildPropertyDetails(WidgetRef ref, PropertyModel? property) {
    final cityAsyncValue = ref.watch(cityByIdProvider(property?.city ?? ''));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(property?.address ?? 'No property found',
            style: const TextStyle(color: textColor1)),
        const Gap(4),
        cityAsyncValue.when(
          data: (city) => Text(city?.name ?? 'No city found',
              style: const TextStyle(color: textColor1)),
          loading: () => const Text('Loading...'),
          error: (error, stack) => const Text('Error fetching city'),
        ),
      ],
    );
  }

  Widget buildBillDetails(WidgetRef ref) {
    final currentBillAsyncValue =
        ref.watch(getLatestWaterBillProvider(account.id!.toInt()));
    return currentBillAsyncValue.when(
      data: (bill) => WaterBill(
        waterBill: bill!,
        showActions: true,
        account: account,
      ),
      loading: () => const CustomCircularProgressIndicator(color: textColor2),
      error: (error, stack) => const Text('Error fetching bill'),
    );
  }
}
