import 'package:json_annotation/json_annotation.dart';

part 'property_model.g.dart';

@JsonSerializable()
class PropertyModel {
  String id;
  String city;
  String community;
  double area_sq_m;
  String address;
  double value;
  String property_type;
  String housing_status;
  String? tax;

  PropertyModel({
    required this.id,
    required this.city,
    required this.community,
    required this.area_sq_m,
    required this.address,
    required this.value,
    required this.property_type,
    required this.housing_status,
    this.tax,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) =>
      _$PropertyModelFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyModelToJson(this);
}
