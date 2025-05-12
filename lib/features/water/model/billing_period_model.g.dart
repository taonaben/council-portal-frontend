// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_period_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingPeriodModel _$BillingPeriodModelFromJson(Map<String, dynamic> json) =>
    BillingPeriodModel(
      last_receipt_date: json['last_receipt_date'] as String,
      bill_date: json['bill_date'] as String,
      due_date: json['due_date'] as String,
    );

Map<String, dynamic> _$BillingPeriodModelToJson(BillingPeriodModel instance) =>
    <String, dynamic>{
      'last_receipt_date': instance.last_receipt_date,
      'bill_date': instance.bill_date,
      'due_date': instance.due_date,
    };
