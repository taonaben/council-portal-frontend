import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/features/accounts/components/account_card.dart';
import 'package:portal/features/accounts/model/account_model.dart';
import 'package:portal/features/accounts/provider/account_provider.dart';
import 'package:portal/features/water/components/latest_bill_card.dart';

class WaterAccountMain extends ConsumerWidget {
  const WaterAccountMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAccountsAsyncValue = ref.watch(allAccountsProvider);
    return allAccountsAsyncValue.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Water Accounts'),
            centerTitle: true,
            backgroundColor: background1,
          ),
          body: data.isEmpty
              ? const Center(child: Text('No accounts found'))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    AccountModel account = data[index];
                    return CurrentBillCard(account: account);
                  },
                ),
        );
      },
      loading: () => const Center(
          child: CustomCircularProgressIndicator(color: textColor2)),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
