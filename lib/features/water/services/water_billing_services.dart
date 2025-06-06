import 'package:portal/core/utils/api_response.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/water/api/water_billing_api.dart';
import 'package:portal/features/water/model/water_bill_model.dart';

class WaterBillingServices {
  final waterApi = WaterBillingApi();

  Future<List<WaterBillModel>> getWaterBillsByAccount(int accountId) async {
    try {
      final response = await waterApi.getWaterBillsByAccount(accountId);
      if (response.success || response.data != null) {
        final dataMap = response.data as Map<String, dynamic>;

        List<dynamic> waterBillList = dataMap['water_bills'];

        if (waterBillList.isNotEmpty && waterBillList.first is WaterBillModel) {
          return waterBillList.cast<WaterBillModel>();
        }

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

  Future<WaterBillModel?> payWaterBill(
      String id, WaterBillModel updatedBill) async {
    try {
      if (updatedBill.amount_paid == null || updatedBill.amount_paid! <= 0) {
        throw Exception('Invalid payment amount: ${updatedBill.amount_paid}');
      }

      DevLogs.logInfo(
          'Paying water bill with ID: $id and amount: ${updatedBill.amount_paid}');
      final response = await waterApi.payWaterBill(id, updatedBill);

      if (response.success) {
        Map<String, dynamic> dataMap = response.data as Map<String, dynamic>;
        return WaterBillModel.fromJson(dataMap);
      } else {
        throw Exception('Failed to pay the water bill: ${response.message}');
      }
    } catch (e) {
      DevLogs.logError('Error paying water bill (ID: $id): $e');
      return null;
    }
  }
}
