// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_period_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingPeriodModel _$BillingPeriodModelFromJson(Map<String, dynamic> json) =>
    BillingPeriodModel(
      last_recipt_date: DateTime.parse(json['last_recipt_date'] as String),
      bill_date: DateTime.parse(json['bill_date'] as String),
      due_date: DateTime.parse(json['due_date'] as String),
    );

Map<String, dynamic> _$BillingPeriodModelToJson(BillingPeriodModel instance) =>
    <String, dynamic>{
      'last_recipt_date': instance.last_recipt_date.toIso8601String(),
      'bill_date': instance.bill_date.toIso8601String(),
      'due_date': instance.due_date.toIso8601String(),
    };
