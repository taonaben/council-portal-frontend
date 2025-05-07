import 'package:json_annotation/json_annotation.dart';

part 'ticket_bundle_model.g.dart';

@JsonSerializable()
class TicketBundleModel {
  String id;
  String purchased_at;
  double quantity;
  double tickets_redeemed;
  int ticket_minutes;
  double price_paid;
  int remaining_tickets;

  TicketBundleModel({
    required this.id,
    required this.purchased_at,
    required this.quantity,
    required this.ticket_minutes,
    required this.price_paid,
    required this.remaining_tickets,
    required this.tickets_redeemed,
  });

  factory TicketBundleModel.fromJson(Map<String, dynamic> json) =>
      _$TicketBundleModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketBundleModelToJson(this);
}
