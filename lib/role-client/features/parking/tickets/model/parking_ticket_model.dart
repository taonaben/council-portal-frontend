import 'package:json_annotation/json_annotation.dart';

part 'parking_ticket_model.g.dart';

@JsonSerializable()
class ParkingTicketModel {
  String id;
  String ticket_number;
  String user;
  String vehicle;
  String city;
  String issued_length;
  DateTime issued_at;
  DateTime expiry_at;
  double amount;
  String status;

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
