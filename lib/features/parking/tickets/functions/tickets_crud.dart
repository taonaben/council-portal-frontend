import 'package:flutter/cupertino.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:portal/features/parking/tickets/services/parking_ticket_services.dart';

class TicketsCrud {
  Future<ParkingTicketModel?> submitTicket({
    required String vehicleId,
    required int issuedMinutes,
    required BuildContext context,
  }) async {
    try {
      final parkingServices = ParkingTicketServices();
      final isSuccess = await parkingServices.submitTicket(
        vehicleId: vehicleId,
        issuedMinutes: issuedMinutes,
      );

      if (isSuccess != null) {
        return isSuccess;
      } else {
        const CustomSnackbar(
                message: "Failed to buy ticket. Please try again later.",
                color: redColor)
            .showSnackBar(context);

        return null;
      }
    } catch (e) {
      DevLogs.logError("Error: ${e.toString()}");
      const CustomSnackbar(
              message: "Failed to buy ticket. Please try again later.",
              color: redColor)
          .showSnackBar(context);
      return null;
    }
  }
}
