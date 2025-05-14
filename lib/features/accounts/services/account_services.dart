import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/accounts/api/account_api.dart';
import 'package:portal/features/accounts/model/account_model.dart';

class AccountServices {
  final accountsApi = AccountApi();

  Future<List<AccountModel>> getAccount() async {
    try {
      final response = await accountsApi.getAccount();
      if (response.success && response.data != null) {
        // Handle both Map and List response types
        List<dynamic> accountList;
        if (response.data is Map<String, dynamic>) {
          Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
          accountList = dataMap['results'];
        } else if (response.data is List) {
          accountList = response.data as List;
        } else {
          DevLogs.logError(
              'Unexpected response type: ${response.data.runtimeType}');
          return [];
        }
        DevLogs.logInfo('Fetched accounts: ${accountList.length}');

        if (accountList.isNotEmpty && accountList.first is AccountModel) {
          return accountList.cast<AccountModel>();
        }

        return accountList
            .map((account) =>
                AccountModel.fromJson(account as Map<String, dynamic>))
            .toList();
      } else {
        DevLogs.logError(
            'Error fetching accounts in services: ${response.message}');
        return [];
      }
    } catch (e) {
      DevLogs.logError('Error in services: $e');
      return [];
    }
  }

  Future<AccountModel?> getAccountById(String id) async {
    try {
      final response = await accountsApi.getAccountById(id);
      if (response.success) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
        return AccountModel.fromJson(dataMap);
      } else {
        throw Exception('Failed to fetch account data');
      }
    } catch (e) {
      DevLogs.logError('Error: $e');
      return null;
    }
  }
}
