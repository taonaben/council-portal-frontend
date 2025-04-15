import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  String id;
  String plate_number;
  String brand;
  String model;
  String color;
  String image;
  String vehicle_type;
  int ticket_count;
  String approval_status;

  VehicleModel({
    required this.id,
    required this.plate_number,
    required this.brand,
    required this.model,
    required this.color,
    required this.image,
    required this.vehicle_type,
    required this.ticket_count,
    required this.approval_status,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
