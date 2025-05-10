import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/water/model/water_bill_model.dart';
import 'package:portal/features/water/services/water_billing_services.dart';

final allWaterBillProvider = FutureProvider<List<WaterBillModel>>((ref) async {
  final waterBillServices = WaterBillingServices();
  try {
    return waterBillServices.getWaterBill();
  } catch (e) {
    return <WaterBillModel>[];
  }
});

final getWaterBillByIdProvider =
    FutureProvider.family<WaterBillModel?, String>((ref, id) async {
  final waterBillServices = WaterBillingServices();
  try {
    return waterBillServices.getWaterBillById(id);
  } catch (e) {
    return null;
  }
});

final getLatestWaterBillProvider = FutureProvider.family<WaterBillModel?, int>((ref, accountId) async {
  final waterBillServices = WaterBillingServices();
  try {
    return waterBillServices.getLatestWaterBill(accountId);
  } catch (e) {
    return null;
  }
});
