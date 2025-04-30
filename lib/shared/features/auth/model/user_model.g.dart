// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      email: json['email'] as String,
      phone_number: json['phoneNumber'] as String,
      city: json['city'] as String,
      is_superuser: json['is_superuser'] as bool?,
      is_staff: json['is_staff'] as bool?,
      is_active: json['is_active'] as bool?,
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'accounts': instance.accounts,
      'email': instance.email,
      'phoneNumber': instance.phone_number,
      'properties': instance.properties,
      'city': instance.city,
      'is_superuser': instance.is_superuser,
      'is_staff': instance.is_staff,
      'is_active': instance.is_active,
    };
