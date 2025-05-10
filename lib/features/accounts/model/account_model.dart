import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel {
  final int? id;
  final String account_number;
  final int user;
  final String property;
  final String water_meter_number;
  final DateTime created_at;

  AccountModel({
    this.id,
    required this.user,
    required this.account_number,
    required this.property,
    required this.water_meter_number,
    required this.created_at,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);
  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
