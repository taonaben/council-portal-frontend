// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) => CityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      districts:
          (json['districts'] as List<dynamic>).map((e) => e as String).toList(),
      longitude: json['longitude'] as String,
      latitude: json['latitude'] as String,
    );

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'districts': instance.districts,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
