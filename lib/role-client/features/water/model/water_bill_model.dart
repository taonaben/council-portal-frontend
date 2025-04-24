import 'package:json_annotation/json_annotation.dart';
import 'package:portal/role-client/features/water/model/billing_period_model.dart';
import 'package:portal/role-client/features/water/model/charges_model.dart';

part 'water_bill_model.g.dart';

@JsonSerializable()
class WaterBillModel {
  String id;
  String user;

  String account_number;
  String city;
  String bill_number;
  ChargesModel charges;
  BillingPeriodModel billing_period;
  DateTime created_at;

  WaterBillModel({
    required this.id,
    required this.user,
    required this.account_number,
    required this.city,
    required this.bill_number,
    required this.charges,
    required this.billing_period,
    required this.created_at,
  });

  factory WaterBillModel.fromJson(Map<String, dynamic> json) =>
      _$WaterBillModelFromJson(json);
  Map<String, dynamic> toJson() => _$WaterBillModelToJson(this);
}
