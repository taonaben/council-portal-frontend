import 'package:json_annotation/json_annotation.dart';
import 'package:portal/features/water/model/billing_period_model.dart';
import 'package:portal/features/water/model/charges_model.dart';
import 'package:portal/features/water/model/water_debt_model.dart';
import 'package:portal/features/water/model/water_usage_model.dart';

part 'water_bill_model.g.dart';

@JsonSerializable()
class WaterBillModel {
  final String id;
  final String user;
  final String city;
  final String bill_number;
  final double credit;
  final WaterUsageModel water_usage;
  final ChargesModel charges;
  final WaterDebtModel water_debt;
  final BillingPeriodModel billing_period;
  final double total_amount;
  final DateTime created_at;

  WaterBillModel({
    required this.id,
    required this.user,
    required this.city,
    required this.bill_number,
    required this.credit,
    required this.water_usage,
    required this.charges,
    required this.water_debt,
    required this.billing_period,
    required this.total_amount,
    required this.created_at,
  });

  factory WaterBillModel.fromJson(Map<String, dynamic> json) =>
      _$WaterBillModelFromJson(json);
  Map<String, dynamic> toJson() => _$WaterBillModelToJson(this);
}
