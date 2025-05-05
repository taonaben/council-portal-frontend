import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/accounts/api/account_api.dart';
import 'package:portal/features/accounts/model/account_model.dart';

class AccountServices {
  final accountsApi = AccountApi();

  Future<List<AccountModel>> getAccount() async {
    try {
      final response = await accountsApi.getAccount();
      if (response.success) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
        List<dynamic> accountList = dataMap['data'];
        return accountList
            .map((json) => AccountModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch account data');
      }
    } catch (e) {
      print('Error: $e');
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
