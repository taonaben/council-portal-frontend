import 'package:json_annotation/json_annotation.dart';

part 'parking_ticket_model.g.dart';

@JsonSerializable()
class ParkingTicketModel {
  String? id; //auto
  String? ticket_number; //auto
  int? user; //auto
  String vehicle; //manual
  String? city; //auto
  String? issued_length; //manual
  String? issued_at; //manual
  String? expiry_at; //manual
  double? amount; //manual
  String? status; //auto
  // String? extend_time;

  ParkingTicketModel({
    this.id,
    this.ticket_number,
    this.user,
    required this.vehicle,
    this.city,
    this.issued_length,
    this.issued_at,
    this.expiry_at,
    this.amount,
    this.status,
    // this.extend_time,
  });

  factory ParkingTicketModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingTicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingTicketModelToJson(this);
}
