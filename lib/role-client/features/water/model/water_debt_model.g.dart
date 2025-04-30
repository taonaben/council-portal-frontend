// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_debt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaterDebtModel _$WaterDebtModelFromJson(Map<String, dynamic> json) =>
    WaterDebtModel(
      over_90_days: json['over_90_days'],
      over_60_days: json['over_60_days'],
      over_30_days: json['over_30_days'],
      total_debt: json['total_debt'],
    );

Map<String, dynamic> _$WaterDebtModelToJson(WaterDebtModel instance) =>
    <String, dynamic>{
      'over_90_days': instance.over_90_days,
      'over_60_days': instance.over_60_days,
      'over_30_days': instance.over_30_days,
      'total_debt': instance.total_debt,
    };
