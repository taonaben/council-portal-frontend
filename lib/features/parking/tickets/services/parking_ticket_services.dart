import 'package:portal/core/utils/logs.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/parking/tickets/api/ticket_api.dart';
import 'package:portal/features/parking/tickets/api/ticket_list.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class ParkingTicketServices {
  var ticketApi = TicketApi();

  Future<List<ParkingTicketModel>> fetchAllTickets() async {
    try {
      var result = await ticketApi.fetchAllTickets();
      if (result.success || result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        List<dynamic> ticketsList = dataMap['tickets'];

        DevLogs.logInfo('Fetched tickets: ${ticketsList.length}');

        if (ticketsList.isNotEmpty && ticketsList.first is ParkingTicketModel) {
          return ticketsList.cast<ParkingTicketModel>();
        }

        // Otherwise, map the JSON objects to ParkingTicketModel instances
        return ticketsList
            .map((ticket) =>
                ParkingTicketModel.fromJson(ticket as Map<String, dynamic>))
            .toList();
      }
      DevLogs.logError('Error fetching tickets: ${result.message}');
      return [];
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return [];
    }
  }

  Future<List<ParkingTicketModel>> fetchTicketsByVehicleId(String id) async {
    try {
      var result = await ticketApi.fetchTicketsByVehicleId(id);
      if (result.success || result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        List<dynamic> ticketsList = dataMap['tickets'];

        DevLogs.logInfo('Fetched tickets in services: ${ticketsList.length}');

        if (ticketsList.isNotEmpty && ticketsList.first is ParkingTicketModel) {
          return ticketsList.cast<ParkingTicketModel>();
        }

        // Otherwise, map the JSON objects to ParkingTicketModel instances
        return ticketsList
            .map((ticket) =>
                ParkingTicketModel.fromJson(ticket as Map<String, dynamic>))
            .toList();
      }
      DevLogs.logError('Error fetching tickets: ${result.message}');
      return [];
    } catch (e) {
      DevLogs.logError('Error in services: ${e.toString()}');
      return [];
    }
  }

  Future<ParkingTicketModel?> addTicket(Map<String, dynamic> body) async {
    try {
      var result = await ticketApi.addTicket(body);
      if (result.success && result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;

        // Check if the ticket is already a ParkingTicketModel instance
        var ticketData = dataMap['ticket'];
        ParkingTicketModel ticket = ticketData is ParkingTicketModel
            ? ticketData
            : ParkingTicketModel.fromJson(ticketData as Map<String, dynamic>);

        DevLogs.logInfo('Ticket added successfully: ${ticket.toJson()}');
        return ticket;
      }
      DevLogs.logError('Error adding ticket add: ${result.message}');
      return null;
    } catch (e) {
      DevLogs.logError('Error in add services: ${e.toString()}');
      return null;
    }
  }

  Future<ParkingTicketModel?> submitTicket({
    required String vehicleId,
    required int issuedMinutes,
  }) async {
    try {
      Map<String, dynamic> body = {
        "vehicle": vehicleId,
        "minutes_issued": issuedMinutes,
      };

      var ticket = await addTicket(body);

      if (ticket != null) {
        DevLogs.logInfo('Ticket submitted successfully: ${ticket.toJson()}');
        return ticket;
      }

      return null;
    } catch (e) {
      DevLogs.logError('Error in submit services: ${e.toString()}');
      return null;
    }
  }

  Future<ParkingTicketModel?> getTicketById(String id) async {
    try {
      var result = await ticketApi.getTicketById(id);
      if (result.success || result.data != null) {
        final dataMap = result.data as Map<String, dynamic>;
        ParkingTicketModel ticket =
            ParkingTicketModel.fromJson(dataMap['ticket']);
        return ticket;
      }
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
    }
    return null; // Return an empty model if not found
  }

  Future<bool> updateTicket(String ticketId, ParkingTicketModel ticket) async {
    try {
      var result = await ticketApi.updateTicket(ticketId, ticket);
      if (result.success) {
        DevLogs.logInfo('Ticket updated successfully: ${ticket.toJson()}');
        return true;
      }
      DevLogs.logError('Error updating ticket: ${result.message}');
      return false;
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }
}
