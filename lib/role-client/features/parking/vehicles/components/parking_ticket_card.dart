import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/role-client/features/parking/tickets/model/parking_ticket_model.dart';

class ParkingTicketCard extends StatelessWidget {
  final ParkingTicketModel ticket;
  const ParkingTicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text(
        ticket.ticket_number,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Issued At: ${ticket.issued_at}"),
          Text("Expiry At: ${ticket.expiry_at}"),
          Text("Status: ${ticket.status}"),
        ],
      ),
      trailing: Text(
        "\$${ticket.amount}",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // Handle ticket tap
      },
    );
  }
}
