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
}
