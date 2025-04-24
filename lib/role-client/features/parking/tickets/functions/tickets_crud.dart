import 'package:flutter/cupertino.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/role-client/features/parking/tickets/services/parking_ticket_services.dart';

class TicketsCrud {
  Future<bool> submitTicket({
    required String vehicle_id,
    required String issued_length,
    required DateTime issued_at,
    required DateTime expiry_at,
    required double amount,
    required BuildContext context,
  }) async {
    try {
      var parkingServices = ParkingTicketServices();
      bool result = await parkingServices.submitTicket(
          vehicle_id: vehicle_id,
          issued_length: issued_length,
          issued_at: issued_at,
          expiry_at: expiry_at,
          amount: amount);

      if (result) {
        return true;
      } else {
        const CustomSnackbar(
                message: 'Failed to submit ticket. Please try again.',
                color: redColor)
            .showSnackBar(context);
        return false;
      }
    } catch (e) {
      DevLogs.logError("Error: ${e.toString()}");
      const CustomSnackbar(
        message: 'An error occurred. Please try again.',
        color: redColor,
      ).showSnackBar(context);
      return false;
    }
  }
}
