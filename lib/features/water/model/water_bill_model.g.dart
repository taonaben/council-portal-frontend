// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaterBillModel _$WaterBillModelFromJson(Map<String, dynamic> json) =>
    WaterBillModel(
      id: json['id'] as String?,
      user: (json['user'] as num?)?.toInt(),
      city: json['city'] as String?,
      bill_number: json['bill_number'] as String?,
      credit: (json['credit'] as num?)?.toDouble(),
      account: (json['account'] as num?)?.toInt(),
      water_usage: json['water_usage'] == null
          ? null
          : WaterUsageModel.fromJson(
              json['water_usage'] as Map<String, dynamic>),
      charges: json['charges'] == null
          ? null
          : ChargesModel.fromJson(json['charges'] as Map<String, dynamic>),
      water_debt: json['water_debt'] == null
          ? null
          : WaterDebtModel.fromJson(json['water_debt'] as Map<String, dynamic>),
      billing_period: json['billing_period'] == null
          ? null
          : BillingPeriodModel.fromJson(
              json['billing_period'] as Map<String, dynamic>),
      total_amount: (json['total_amount'] as num?)?.toDouble(),
      amount_paid: (json['amount_paid'] as num?)?.toDouble(),
      remaining_balance: (json['remaining_balance'] as num?)?.toDouble(),
      payment_status: json['payment_status'] as String?,
      created_at: json['created_at'] as String?,
    );

Map<String, dynamic> _$WaterBillModelToJson(WaterBillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'city': instance.city,
      'bill_number': instance.bill_number,
      'credit': instance.credit,
      'account': instance.account,
      'water_usage': instance.water_usage,
      'charges': instance.charges,
      'water_debt': instance.water_debt,
      'billing_period': instance.billing_period,
      'total_amount': instance.total_amount,
      'amount_paid': instance.amount_paid,
      'remaining_balance': instance.remaining_balance,
      'payment_status': instance.payment_status,
      'created_at': instance.created_at,
    };
