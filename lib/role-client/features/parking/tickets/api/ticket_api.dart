import 'package:portal/core/utils/api_response.dart';
import 'package:portal/role-client/features/parking/tickets/api/ticket_list.dart';

class TicketApi {

  Future<ApiResponse> fetchTickets() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      return ApiResponse(
        success: true,
        data: {'tickets': allTickets}, // Replace with actual ticket data
        message: 'Tickets fetched successfully',
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: e.toString(),
        data: {'tickets': []},
      );
    }
  }
}