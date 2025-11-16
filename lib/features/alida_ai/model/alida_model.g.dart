// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alida_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlidaModel _$AlidaModelFromJson(Map<String, dynamic> json) => AlidaModel(
      sender: json['sender'] as String,
      content: json['content'] as String,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$AlidaModelToJson(AlidaModel instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'content': instance.content,
      'created_at': instance.created_at,
    };

AlidaResponseModel _$AlidaResponseModelFromJson(Map<String, dynamic> json) =>
    AlidaResponseModel(
      response: json['response'] as String,
      created_at: json['created_at'] as String,
    );

Map<String, dynamic> _$AlidaResponseModelToJson(AlidaResponseModel instance) =>
    <String, dynamic>{
      'response': instance.response,
      'created_at': instance.created_at,
    };
