// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_usage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaterUsageModel _$WaterUsageModelFromJson(Map<String, dynamic> json) =>
    WaterUsageModel(
      previous_reading: (json['previous_reading'] as num).toDouble(),
      current_reading: (json['current_reading'] as num).toDouble(),
      consumption: (json['consumption'] as num).toDouble(),
      date_recorded: DateTime.parse(json['date_recorded'] as String),
    );

Map<String, dynamic> _$WaterUsageModelToJson(WaterUsageModel instance) =>
    <String, dynamic>{
      'previous_reading': instance.previous_reading,
      'current_reading': instance.current_reading,
      'consumption': instance.consumption,
      'date_recorded': instance.date_recorded.toIso8601String(),
    };
