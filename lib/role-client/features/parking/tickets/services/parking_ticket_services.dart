import 'package:portal/core/utils/logs.dart';
import 'package:portal/role-client/features/parking/tickets/api/ticket_api.dart';
import 'package:portal/role-client/features/parking/tickets/model/parking_ticket_model.dart';

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
}
