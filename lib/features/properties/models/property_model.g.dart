// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyModel _$PropertyModelFromJson(Map<String, dynamic> json) =>
    PropertyModel(
      id: json['id'] as String,
      city: json['city'] as String,
      community: json['community'] as String,
      area_sq_m: (json['area_sq_m'] as num).toDouble(),
      address: json['address'] as String,
      value: (json['value'] as num).toDouble(),
      property_type: json['property_type'] as String,
      housing_status: json['housing_status'] as String,
      tax: json['tax'] as String?,
    );

Map<String, dynamic> _$PropertyModelToJson(PropertyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'community': instance.community,
      'area_sq_m': instance.area_sq_m,
      'address': instance.address,
      'value': instance.value,
      'property_type': instance.property_type,
      'housing_status': instance.housing_status,
      'tax': instance.tax,
    };
