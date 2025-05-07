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



  Future<bool> addTicket(ParkingTicketModel ticket) async {
    try {
      var result = await ticketApi.addTicket(ticket);
      if (result.success) {
        DevLogs.logInfo('Ticket added successfully: ${ticket.toJson()}');
        return true;
      }
      DevLogs.logError('Error adding ticket: ${result.message}');
      return false;
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
    }
  }

  Future<bool> submitTicket({
    required String vehicle_id,
    required String issued_length,
  }) async {
    try {
      var uuid = const Uuid();
      String uuidString = uuid.v4(); // Generates a UUID v4 string

      String user = await getSP("user");

      ParkingTicketModel ticket = ParkingTicketModel(
        id: uuidString,
        ticket_number: generateTicketNumber(),
        user: int.parse(user),
        vehicle: vehicle_id,
        city: cities[random.nextInt(cities.length)],
        issued_length: issued_length,
        status: "active",
      );

      return await addTicket(ticket);
    } catch (e) {
      DevLogs.logError('Error: ${e.toString()}');
      return false;
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
