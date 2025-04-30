import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String username;
  final String first_name;
  final String last_name;
  final List<String>? accounts;
  final String email;
  final String phone_number;
  final List<String>? properties;
  final String city;
  final bool? is_superuser;
  final bool? is_staff;
  final bool? is_active;

  User({
    this.id,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone_number,
    required this.city,
    this.is_superuser,
    this.is_staff,
    this.is_active,
    this.accounts,
    this.properties,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.empty() => User(
  id: 0,
  first_name: "",
  last_name: "",
  email: "",
  city: "",
  phone_number: "",
  username: "",
  is_superuser: false,
  is_staff: false,
  is_active: false,
);

}
