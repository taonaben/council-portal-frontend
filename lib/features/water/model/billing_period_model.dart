import 'package:json_annotation/json_annotation.dart';

part 'billing_period_model.g.dart';

@JsonSerializable()
class BillingPeriodModel {
  final String last_receipt_date;
  final String bill_date;
  final String due_date;

  BillingPeriodModel({
    required this.last_receipt_date,
    required this.bill_date,
    required this.due_date,
  });

  factory BillingPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$BillingPeriodModelFromJson(json);
  Map<String, dynamic> toJson() => _$BillingPeriodModelToJson(this);
}
