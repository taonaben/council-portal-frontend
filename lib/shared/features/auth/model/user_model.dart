import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String phoneNumber;
  final String city;
  final bool isAdmin;
  final bool isStaff;
  final bool isActive;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.city,
    required this.isAdmin,
    required this.isStaff,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
