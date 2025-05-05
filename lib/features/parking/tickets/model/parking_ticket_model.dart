import 'package:json_annotation/json_annotation.dart';

part 'parking_ticket_model.g.dart';

@JsonSerializable()
class ParkingTicketModel {
  String id; //auto
  String ticket_number; //auto
  String user; //auto
  String vehicle; //manual
  String city; //auto
  String issued_length; //manual
  DateTime issued_at; //manual
  DateTime expiry_at; //manual
  double amount; //manual
  String status; //auto

  ParkingTicketModel({
    required this.id,
    required this.ticket_number,
    required this.user,
    required this.vehicle,
    required this.city,
    required this.issued_length,
    required this.issued_at,
    required this.expiry_at,
    required this.amount,
    required this.status,
  });
  factory ParkingTicketModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingTicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingTicketModelToJson(this);
}
