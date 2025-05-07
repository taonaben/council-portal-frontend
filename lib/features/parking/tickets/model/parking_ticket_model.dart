import 'package:json_annotation/json_annotation.dart';

part 'parking_ticket_model.g.dart';

@JsonSerializable()
class ParkingTicketModel {
  String? id; //auto
  String? ticket_number; //auto
  int? user; //auto
  String vehicle; //manual
  String? city; //auto
  String? issued_at; //manual
  int? minutes_issued;
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
    this.minutes_issued,
    this.issued_at,
    this.expiry_at,
    this.amount,
    this.status,
    // this.extend_time,
  });

  static ParkingTicketModel empty() {
    return ParkingTicketModel(
      id: null,
      ticket_number: null,
      user: null,
      vehicle: '',
      city: null,
      minutes_issued: null,
      issued_at: null,
      expiry_at: null,
      amount: null,
      status: null,
    );
  }

  factory ParkingTicketModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingTicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingTicketModelToJson(this);
}
