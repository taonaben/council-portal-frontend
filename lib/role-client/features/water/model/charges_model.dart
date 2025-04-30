import 'package:json_annotation/json_annotation.dart';

part 'charges_model.g.dart';

@JsonSerializable()
class ChargesModel {
  final double rates;
  final double water_charges;
  final double sewerage;
  final double street_lighting;
  final double roads_charge;
  final double education_levy;
  final double total_due;

  ChargesModel({
    required this.rates,
    required this.water_charges,
    required this.sewerage,
    required this.street_lighting,
    required this.roads_charge,
    required this.education_levy,
    required this.total_due,
  });

  factory ChargesModel.fromJson(Map<String, dynamic> json) =>
      _$ChargesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChargesModelToJson(this);
}
