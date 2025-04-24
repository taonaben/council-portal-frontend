
import 'package:json_annotation/json_annotation.dart';

part 'charges_model.g.dart';

@JsonSerializable()
class ChargesModel {
  double balance_forward;
  double water_charges;
  double sewerage;
  double street_lighting;
  double roads_charge;
  double education_levy;
  double total_due;

  ChargesModel({
    required this.balance_forward,
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
