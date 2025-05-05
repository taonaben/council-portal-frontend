import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/accounts/model/account_model.dart';
import 'package:portal/features/accounts/services/account_services.dart';

final allAccountsProvider =
    FutureProvider<List<AccountModel>>((ref) async {
  final accountServices = AccountServices();
  try {
    return accountServices.getAccount();
  } catch (e) {
    return <AccountModel>[];
  }
});

final getAccountByIdProvider =
    FutureProvider.family<AccountModel?, String>((ref, id) async {
  final accountServices = AccountServices();
  try {
    return accountServices.getAccountById(id);
  } catch (e) {
    return null;
  }
});

