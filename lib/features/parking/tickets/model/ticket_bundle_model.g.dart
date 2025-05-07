// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_bundle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketBundleModel _$TicketBundleModelFromJson(Map<String, dynamic> json) =>
    TicketBundleModel(
      id: json['id'] as String,
      purchased_at: json['purchased_at'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      ticket_minutes: (json['ticket_minutes'] as num).toInt(),
      price_paid: (json['price_paid'] as num).toDouble(),
      remaining_tickets: (json['remaining_tickets'] as num).toInt(),
      tickets_redeemed: (json['tickets_redeemed'] as num).toDouble(),
    );

Map<String, dynamic> _$TicketBundleModelToJson(TicketBundleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchased_at': instance.purchased_at,
      'quantity': instance.quantity,
      'tickets_redeemed': instance.tickets_redeemed,
      'ticket_minutes': instance.ticket_minutes,
      'price_paid': instance.price_paid,
      'remaining_tickets': instance.remaining_tickets,
    };
