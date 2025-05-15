import 'package:json_annotation/json_annotation.dart';

part 'alida_model.g.dart';

@JsonSerializable()
class AlidaModel {
  String sender;
  String content;
  String created_at;

  AlidaModel({
    required this.sender,
    required this.content,
    required this.created_at,
  });

  factory AlidaModel.fromJson(Map<String, dynamic> json) =>
      _$AlidaModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlidaModelToJson(this);
}

@JsonSerializable()
class AlidaResponseModel {
  String response;
  String created_at;

  AlidaResponseModel({
    required this.response,
    required this.created_at,
  });

  factory AlidaResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AlidaResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlidaResponseModelToJson(this);
}
