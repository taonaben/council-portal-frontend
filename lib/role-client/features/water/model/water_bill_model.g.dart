// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaterBillModel _$WaterBillModelFromJson(Map<String, dynamic> json) =>
    WaterBillModel(
      id: json['id'] as String,
      user: json['user'] as String,
      account_number: json['account_number'] as String,
      city: json['city'] as String,
      bill_number: json['bill_number'] as String,
      charges: ChargesModel.fromJson(json['charges'] as Map<String, dynamic>),
      billing_period: BillingPeriodModel.fromJson(
          json['billing_period'] as Map<String, dynamic>),
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$WaterBillModelToJson(WaterBillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'account_number': instance.account_number,
      'city': instance.city,
      'bill_number': instance.bill_number,
      'charges': instance.charges,
      'billing_period': instance.billing_period,
      'created_at': instance.created_at.toIso8601String(),
    };
