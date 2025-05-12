import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  String? id;
  String plate_number;
  String brand;
  String model;
  String color;
  String? image;
  String vehicle_type;
  String? tax;
  List<String>? parking_tickets;
  int? ticket_count;
  String? approval_status;
  bool? is_active;

  VehicleModel({
    this.id,
    required this.plate_number,
    required this.brand,
    required this.model,
    required this.color,
    this.image,
    required this.vehicle_type,
    this.tax,
    this.parking_tickets,
    this.ticket_count,
    this.approval_status,
    this.is_active,
  });

  VehicleModel copyWith({
    String? id,
    String? plate_number,
    String? brand,
    String? model,
    String? color,
    String? image,
    String? vehicle_type,
    String? tax,
    List<String>? parking_tickets,
    int? ticket_count,
    String? approval_status,
    bool? is_active,
  }) {
    return VehicleModel(
      id: id ?? this.id,
      plate_number: plate_number ?? this.plate_number,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      image: image ?? this.image,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      tax: tax ?? this.tax,
      parking_tickets: parking_tickets ?? this.parking_tickets,
      ticket_count: ticket_count ?? this.ticket_count,
      approval_status: approval_status ?? this.approval_status,
      is_active: is_active ?? this.is_active,
    );
  }

  

  factory VehicleModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleModelFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
