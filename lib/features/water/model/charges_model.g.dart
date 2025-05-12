// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charges_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargesModel _$ChargesModelFromJson(Map<String, dynamic> json) => ChargesModel(
      rates: (json['rates'] as num).toDouble(),
      water_charges: (json['water_charges'] as num).toDouble(),
      sewerage: (json['sewerage'] as num).toDouble(),
      street_lighting: (json['street_lighting'] as num).toDouble(),
      roads_charge: (json['roads_charge'] as num).toDouble(),
      education_levy: (json['education_levy'] as num).toDouble(),
      total_due: (json['total_due'] as num).toDouble(),
    );

Map<String, dynamic> _$ChargesModelToJson(ChargesModel instance) =>
    <String, dynamic>{
      'rates': instance.rates,
      'water_charges': instance.water_charges,
      'sewerage': instance.sewerage,
      'street_lighting': instance.street_lighting,
      'roads_charge': instance.roads_charge,
      'education_levy': instance.education_levy,
      'total_due': instance.total_due,
    };
