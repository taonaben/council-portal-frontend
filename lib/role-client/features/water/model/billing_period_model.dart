import 'package:json_annotation/json_annotation.dart';

part 'billing_period_model.g.dart';

@JsonSerializable()
class BillingPeriodModel {
  final DateTime last_recipt_date;
  final DateTime bill_date;
  final DateTime due_date;

  BillingPeriodModel({
    required this.last_recipt_date,
    required this.bill_date,
    required this.due_date,
  });

  factory BillingPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$BillingPeriodModelFromJson(json);
  Map<String, dynamic> toJson() => _$BillingPeriodModelToJson(this);
}
