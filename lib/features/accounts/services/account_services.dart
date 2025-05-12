import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/accounts/api/account_api.dart';
import 'package:portal/features/accounts/model/account_model.dart';

class AccountServices {
  final accountsApi = AccountApi();

  Future<List<AccountModel>> getAccount() async {
    try {
      final response = await accountsApi.getAccount();
      if (response.success && response.data != null) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
        List<dynamic> accountList = dataMap['results']; // Use 'results' key
        DevLogs.logInfo('Fetched accounts: ${accountList.length}');

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
