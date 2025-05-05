
import 'package:json_annotation/json_annotation.dart';

part 'registration_model.g.dart';

@JsonSerializable()
class RegistrationModel {
  final String username;
  final String email;
  final String password;
  final String password2;
  final String first_name;
  final String last_name;
  final String phone_number;
  final String city;

  RegistrationModel({
    required this.username,
    required this.email,
    required this.password,
    required this.password2,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.city,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationModelToJson(this);
}
