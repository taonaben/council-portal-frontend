// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingTicketModel _$ParkingTicketModelFromJson(Map<String, dynamic> json) =>
    ParkingTicketModel(
      id: json['id'] as String?,
      ticket_number: json['ticket_number'] as String?,
      user: (json['user'] as num?)?.toInt(),
      vehicle: json['vehicle'] as String,
      city: json['city'] as String?,
      minutes_issued: (json['minutes_issued'] as num?)?.toInt(),
      issued_at: json['issued_at'] as String?,
      expiry_at: json['expiry_at'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ParkingTicketModelToJson(ParkingTicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket_number': instance.ticket_number,
      'user': instance.user,
      'vehicle': instance.vehicle,
      'city': instance.city,
      'issued_at': instance.issued_at,
      'minutes_issued': instance.minutes_issued,
      'expiry_at': instance.expiry_at,
      'amount': instance.amount,
      'status': instance.status,
    };
