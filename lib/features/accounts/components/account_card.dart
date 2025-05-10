import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/accounts/model/account_model.dart';
import 'package:portal/features/properties/providers/properties_provider.dart';

class AccountCard extends ConsumerWidget {
  final AccountModel account;
  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertyAsyncValue =
        ref.watch(propertyByIdProvider(account.property));

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uniBorderRadius)),
      elevation: 3,
      color: background1,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shadowColor: blackColor.withOpacity(.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow(title: 'Account Number', value: account.account_number),
            const SizedBox(height: 8),
            propertyAsyncValue.when(
              data: (property) {
                return buildRow(
                  title: 'Property Address',
                  value: property?.address ?? 'No property found',
                );
              },
              loading: () => const Text('Loading...'),
              error: (error, stack) => Text('Error fetching property'),
            ),
            const SizedBox(height: 8),
            buildRow(
                title: 'Water Meter Number', value: account.water_meter_number),
            const SizedBox(height: 8),
            buildRow(
                title: 'Created At', value: dateFormatted(account.created_at)),
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
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          value,
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
