// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationModel _$RegistrationModelFromJson(Map<String, dynamic> json) =>
    RegistrationModel(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      password2: json['password2'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      phone_number: json['phone_number'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$RegistrationModelToJson(RegistrationModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'password2': instance.password2,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'phone_number': instance.phone_number,
      'city': instance.city,
    };
