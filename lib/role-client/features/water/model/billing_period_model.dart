
import 'package:json_annotation/json_annotation.dart';

part 'billing_period_model.g.dart';

@JsonSerializable()
class BillingPeriodModel {
  DateTime last_recipt_date;
  DateTime bill_date;
  DateTime due_date;

  BillingPeriodModel({
    required this.last_recipt_date,
    required this.bill_date,
    required this.due_date,
  });

  factory BillingPeriodModel.fromJson(Map<String, dynamic> json) =>
      _$BillingPeriodModelFromJson(json);
  Map<String, dynamic> toJson() => _$BillingPeriodModelToJson(this);
}
