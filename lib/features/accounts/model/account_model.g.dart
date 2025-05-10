// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      user: (json['user'] as num).toInt(),
      account_number: json['account_number'] as String,
      property: json['property'] as String,
      water_meter_number: json['water_meter_number'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      'account_number': instance.account_number,
      'user': instance.user,
      'property': instance.property,
      'water_meter_number': instance.water_meter_number,
      'created_at': instance.created_at.toIso8601String(),
    };
