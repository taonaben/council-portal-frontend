import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/accounts/model/account_model.dart';
import 'package:portal/features/cities/providers/cities_providers.dart';
import 'package:portal/features/properties/models/property_model.dart';
import 'package:portal/features/properties/providers/properties_provider.dart';
import 'package:portal/features/water/views/account_history_page.dart';
import 'package:portal/features/water/views/account_insights_page.dart';

class AccountWaterDetails extends ConsumerStatefulWidget {
  final AccountModel account;
  const AccountWaterDetails({super.key, required this.account});

  @override
  ConsumerState<AccountWaterDetails> createState() =>
      _AccountWaterDetailsState();
}

class _AccountWaterDetailsState extends ConsumerState<AccountWaterDetails> {
  Future<String> _getUserFullName() async {
    return await getSP("user_full_name") ?? "Unknown User";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Account Details"),
          centerTitle: true,
          backgroundColor: background1,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildAccountDetails(),
            TabBar(
              indicator: BoxDecoration(
                border: Border.all(color: background2),
                borderRadius: BorderRadius.circular(uniBorderRadius),
              ),
              indicatorColor: Colors.transparent, // Remove default underline
              labelColor: primaryColor,
              unselectedLabelColor: textColor2,
              dividerHeight: 0,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, size: 18),
                      SizedBox(width: 8),
                      Text("History"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insights, size: 18),
                      SizedBox(width: 8),
                      Text("Insights"),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AccountWaterBillsHistoryPage(accountId: widget.account.id!),
                  AccountInsightsPage(
                    accountId: widget.account.id!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountDetails() {
    final propertyAsyncValue =
        ref.watch(propertyByIdProvider(widget.account.property));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: background1,
            border: Border.all(
              color: textColor2,
            ),
            borderRadius: BorderRadius.circular(uniBorderRadius + 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<String>(
              future: _getUserFullName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading...",
                      style: TextStyle(color: textColor2));
                }
                return Text(
                  snapshot.data ?? "Error loading name",
                  style: const TextStyle(
                      color: textColor2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
            const Gap(4),
            buildRow(
                title: "Account Number", value: widget.account.account_number),
            const Gap(4),
            propertyAsyncValue.when(
              data: (property) => buildPropertyDetails(property),
              loading: () => const Text('Loading...'),
              error: (error, stack) => const Text('Error fetching property'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPropertyDetails(PropertyModel? property) {
    final cityAsyncValue = ref.watch(cityByIdProvider(property?.city ?? ''));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildRow(
            title: "Address", value: property?.address ?? 'No property found'),
        const Gap(4),
        cityAsyncValue.when(
          data: (city) =>
              buildRow(title: "city", value: city?.name ?? 'No city found'),
          loading: () => const Text('Loading...'),
          error: (error, stack) => const Text('Error fetching city'),
        ),
      ],
    );
  }

  Widget buildRow(
      {required String title, required dynamic value, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          capitalize(title),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor2,
          ),
        ),
        Text(
          value is double ? value.toStringAsFixed(2) : value.toString(),
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor2,
          ),
        ),
      ],
    );
  }
}
