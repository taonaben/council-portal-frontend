import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/features/parking/tickets/provider/parking_ticket_provider.dart';
import 'package:portal/features/parking/tickets/components/parking_ticket_card.dart';

class TicketHistoryPage extends ConsumerWidget {
  const TicketHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTicketsAsyncValue = ref.watch(allTicketsProvider);
    return allTicketsAsyncValue.when(
      data: (tickets) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ticket History'),
            centerTitle: true,
          ),
          body: tickets.isEmpty
              ? const Center(
                  child: Text(
                    'No tickets found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
              : ListView.builder(
                  itemCount: tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = tickets[index];
                    return ParkingTicketCard(ticket: ticket);
                  },
                ),
        );
      },
      loading: () => const Center(
          child: CustomCircularProgressIndicator(color: textColor2)),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
