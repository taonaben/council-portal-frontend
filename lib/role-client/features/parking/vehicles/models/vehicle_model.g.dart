// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleModel _$VehicleModelFromJson(Map<String, dynamic> json) => VehicleModel(
      id: json['id'] as String,
      plate_number: json['plate_number'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      color: json['color'] as String,
      image: json['image'] as String,
      vehicle_type: json['vehicle_type'] as String,
      ticket_count: (json['ticket_count'] as num).toInt(),
      approval_status: json['approval_status'] as String,
    );

Map<String, dynamic> _$VehicleModelToJson(VehicleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plate_number': instance.plate_number,
      'brand': instance.brand,
      'model': instance.model,
      'color': instance.color,
      'image': instance.image,
      'vehicle_type': instance.vehicle_type,
      'ticket_count': instance.ticket_count,
      'approval_status': instance.approval_status,
    };
