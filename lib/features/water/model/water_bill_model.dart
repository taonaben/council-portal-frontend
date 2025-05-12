import 'package:json_annotation/json_annotation.dart';
import 'package:portal/features/water/model/billing_period_model.dart';
import 'package:portal/features/water/model/charges_model.dart';
import 'package:portal/features/water/model/water_debt_model.dart';
import 'package:portal/features/water/model/water_usage_model.dart';

part 'water_bill_model.g.dart';

@JsonSerializable()
class WaterBillModel {
  final String? id;
  final int? user;
  final String? city; // Made nullable
  final String? bill_number; // Made nullable
  final double? credit; // Made nullable
  final int? account;
  final WaterUsageModel? water_usage;
  final ChargesModel? charges;
  final WaterDebtModel? water_debt;
  final BillingPeriodModel? billing_period;
  final double? total_amount;
  final double? amount_paid;
  final double? remaining_balance;
  final String? payment_status; // Made nullable
  final String? created_at; // Made nullable

  WaterBillModel({
    this.id,
    this.user,
    this.city,
    this.bill_number,
    this.credit,
    this.account,
    this.water_usage,
    this.charges,
    this.water_debt,
    this.billing_period,
    this.total_amount,
    this.amount_paid,
    this.remaining_balance,
    this.payment_status,
    this.created_at,
  });

  WaterBillModel copyWith({
    String? id,
    int? user,
    String? city,
    String? bill_number,
    double? credit,
    int? account,
    WaterUsageModel? water_usage,
    ChargesModel? charges,
    WaterDebtModel? water_debt,
    BillingPeriodModel? billing_period,
    double? total_amount,
    double? amount_paid,
    double? remaining_balance,
    String? payment_status,
    String? created_at,
  }) {
    return WaterBillModel(
      id: id ?? this.id,
      user: user ?? this.user,
      city: city ?? this.city,
      bill_number: bill_number ?? this.bill_number,
      credit: credit ?? this.credit,
      account: account ?? this.account,
      water_usage: water_usage ?? this.water_usage,
      charges: charges ?? this.charges,
      water_debt: water_debt ?? this.water_debt,
      billing_period: billing_period ?? this.billing_period,
      total_amount: total_amount ?? this.total_amount,
      amount_paid: amount_paid ?? this.amount_paid,
      remaining_balance: remaining_balance ?? this.remaining_balance,
      payment_status: payment_status ?? this.payment_status,
      created_at: created_at ?? this.created_at,
    );
  }

  factory WaterBillModel.fromJson(Map<String, dynamic> json) =>
      _$WaterBillModelFromJson(json);
  Map<String, dynamic> toJson() => _$WaterBillModelToJson(this);
}
