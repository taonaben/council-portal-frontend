import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/water/api/water_billing_api.dart';
import 'package:portal/features/water/model/water_bill_model.dart';

class WaterBillingServices {
  final waterApi = WaterBillingApi();

  Future<List<WaterBillModel>> getWaterBill() async {
    try {
      final response = await waterApi.getWaterBill();
      if (response.success) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;

        List<dynamic> waterBillList = dataMap['data'];
        return waterBillList
            .map(
                (json) => WaterBillModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch water bill data');
      }
    } catch (e) {
      DevLogs.logError('Error: $e');
      return [];
    }
  }

  Future<WaterBillModel?> getWaterBillById(String id) async {
    try {
      final response = await waterApi.getWaterBillById(id);
      if (response.success) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
        return WaterBillModel.fromJson(dataMap);
      } else {
        throw Exception('Failed to fetch water bill data');
      }
    } catch (e) {
      DevLogs.logError('Error: $e');
      return null;
    }
  }

  Future<WaterBillModel?> getLatestWaterBill(int accountId) async {
    try {
      DevLogs.logInfo('Fetching latest water bill for account ID: $accountId');
      final response = await waterApi.getLatestWaterBill(accountId);
      if (response.success) {
        final waterBill = response.data['water_bill'] as WaterBillModel;
        DevLogs.logInfo(
            'Successfully fetched water bill: ${waterBill.toJson()}');
        return waterBill;
      } else {
        DevLogs.logError('Failed to fetch water bill: ${response.message}');
        throw Exception(response.message);
      }
    } catch (e) {
      DevLogs.logError('Error fetching latest water bill: $e');
      return null;
    }
  }

  Future<WaterBillModel?> payWaterBill(String id, double amount) async {
    try {
      final response = await waterApi.payWaterBill(id, amount);
      if (response.success) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;

        if (dataMap.isNotEmpty && dataMap['water_bill'] is WaterBillModel) {
          return dataMap['water_bill'] as WaterBillModel;
        }

        return WaterBillModel.fromJson(dataMap);
      } else {
        throw Exception('Failed to pay the water bill');
      }
    } catch (e) {
      DevLogs.logError(
          'Error paying water bill (ID: $id, Amount: $amount): $e');
      return null;
    }
  }
}
