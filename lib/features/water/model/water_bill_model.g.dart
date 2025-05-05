// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaterBillModel _$WaterBillModelFromJson(Map<String, dynamic> json) =>
    WaterBillModel(
      id: json['id'] as String,
      user: json['user'] as String,
      city: json['city'] as String,
      bill_number: json['bill_number'] as String,
      credit: (json['credit'] as num).toDouble(),
      water_usage:
          WaterUsageModel.fromJson(json['water_usage'] as Map<String, dynamic>),
      charges: ChargesModel.fromJson(json['charges'] as Map<String, dynamic>),
      water_debt:
          WaterDebtModel.fromJson(json['water_debt'] as Map<String, dynamic>),
      billing_period: BillingPeriodModel.fromJson(
          json['billing_period'] as Map<String, dynamic>),
      total_amount: (json['total_amount'] as num).toDouble(),
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$WaterBillModelToJson(WaterBillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'city': instance.city,
      'bill_number': instance.bill_number,
      'credit': instance.credit,
      'water_usage': instance.water_usage,
      'charges': instance.charges,
      'water_debt': instance.water_debt,
      'billing_period': instance.billing_period,
      'total_amount': instance.total_amount,
      'created_at': instance.created_at.toIso8601String(),
    };
