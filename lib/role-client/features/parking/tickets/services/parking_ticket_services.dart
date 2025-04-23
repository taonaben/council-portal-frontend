import 'package:portal/core/utils/logs.dart';
import 'package:portal/role-client/features/parking/tickets/api/ticket_api.dart';
import 'package:portal/role-client/features/parking/tickets/api/ticket_list.dart';
import 'package:portal/role-client/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:uuid/v4.dart';

class ParkingTicketServices {
  var ticketApi = TicketApi();

  Future<List<ParkingTicketModel>> fetchTickets() async {
    try {
      var result = await ticketApi.fetchTickets();
      if (!result.success || result.data == null) {
        DevLogs.logError(
            'Error fetching tickets: ${result.message ?? 'Unknown error'}');
        return [];
      }

      final dataMap = result.data as Map<String, dynamic>;
      final ticketsList = dataMap['tickets'] as List<dynamic>?;

      if (ticketsList == null) {
        DevLogs.logError('Error: Tickets list is null');
        return [];
      }

      return ticketsList
          .map((ticket) => ParkingTicketModel.fromJson(ticket))
          .toList();
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return [];
    }
  }

  Future<bool> addTicket(ParkingTicketModel ticket) async {
    try {
      var result = await ticketApi.addTicket(ticket);
      if (!result.success) {
        DevLogs.logError(
            'Error adding ticket: ${result.message ?? 'Unknown error'}');
        return false;
      }
      return true;
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }

  Future<bool> submitTicket({
    required String vehicle_id,
    required String issued_length,
    required DateTime issued_at,
    required DateTime expiry_at,
    required double amount,
  }) async {
    try {
      ParkingTicketModel ticket = ParkingTicketModel(
        id: const UuidV4().toString(),
        ticket_number: generateTicketNumber(),
        user: 'Benjamin',
        vehicle: vehicle_id,
        city: cities[random.nextInt(cities.length)],
        issued_length: issued_length,
        issued_at: issued_at,
        expiry_at: expiry_at,
        amount: amount,
        status: "active",
      );

      var result = addTicket(ticket);
      return result;
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }
}
