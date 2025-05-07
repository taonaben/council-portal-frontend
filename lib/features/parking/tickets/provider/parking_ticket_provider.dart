import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:portal/features/parking/tickets/services/parking_ticket_services.dart';

final allTicketsProvider =
    FutureProvider<List<ParkingTicketModel>>((ref) async {
  try {
    return ParkingTicketServices().fetchAllTickets().then((value) {
      if (value.isNotEmpty) {
        return value;
      } else {
        throw Exception('No tickets found');
      }
    });
  } catch (e) {
    throw Exception('Error fetching tickets: $e');
  }
});


final parkingTicketsByVehicleProvider =
    FutureProviderFamily<List<ParkingTicketModel>, String>((ref, id) async {
  try {
    return ParkingTicketServices().fetchTicketsByVehicleId(id).then((value) {
      if (value.isNotEmpty) {
        return value;
      } else {
        throw Exception('No tickets found');
      }
    });
  } catch (e) {
    throw Exception('Error fetching tickets: $e');
  }
});

