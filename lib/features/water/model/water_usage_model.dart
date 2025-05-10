import 'package:json_annotation/json_annotation.dart';

part 'water_usage_model.g.dart';

@JsonSerializable()
class WaterUsageModel {
  final double previous_reading;
  final double current_reading;
  final double consumption;
  final String date_recorded;

  WaterUsageModel({
    required this.previous_reading,
    required this.current_reading,
    required this.consumption,
    required this.date_recorded,
  });

  factory WaterUsageModel.fromJson(Map<String, dynamic> json) =>
      _$WaterUsageModelFromJson(json);
  Map<String, dynamic> toJson() => _$WaterUsageModelToJson(this);
}
