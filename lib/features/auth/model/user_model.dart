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

  User copyWith({
    int? id,
    String? username,
    String? first_name,
    String? last_name,
    String? email,
    String? phone_number,
    String? city,
    bool? is_superuser,
    bool? is_staff,
    bool? is_active,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      phone_number: phone_number ?? this.phone_number,
      city: city ?? this.city,
      is_superuser: is_superuser ?? this.is_superuser,
      is_staff: is_staff ?? this.is_staff,
      is_active: is_active ?? this.is_active,
    );
  }

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
