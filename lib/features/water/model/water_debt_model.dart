import 'package:json_annotation/json_annotation.dart';

part 'water_debt_model.g.dart';

@JsonSerializable()
class WaterDebtModel {
  final double over_90_days;
  final double over_60_days;
  final double over_30_days;
  final double total_debt;

  WaterDebtModel({
    required this.over_90_days,
    required this.over_60_days,
    required this.over_30_days,
    required this.total_debt,
  });

  factory WaterDebtModel.fromJson(Map<String, dynamic> json) =>
      _$WaterDebtModelFromJson(json);
  Map<String, dynamic> toJson() => _$WaterDebtModelToJson(this);
}
