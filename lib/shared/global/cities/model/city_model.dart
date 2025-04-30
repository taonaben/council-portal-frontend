import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel {
  final String id;
  final String name;
  final List<String> districts;
  final String longitude;
  final String latitude;

  CityModel({
    required this.id,
    required this.name,
    required this.districts,
    required this.longitude,
    required this.latitude,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
