import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/features/accounts/model/account_model.dart';
import 'package:portal/features/accounts/provider/account_provider.dart';

class AccountMain extends ConsumerWidget {
  const AccountMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAccountsAsyncValue = ref.watch(allAccountsProvider);
    return allAccountsAsyncValue.when(
      data: (data) {
        return Scaffold(
          body: data.isEmpty
              ? const Center(child: Text('No accounts found'))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    AccountModel account = data[index];
                    return ListTile(
                      title: Text(account.account_number),
                      subtitle: Text(account.water_meter_number),
                    );
                  },
                ),
        );
      },
      loading: () => const Center(child: CustomCircularProgressIndicator(color: textColor2)),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
