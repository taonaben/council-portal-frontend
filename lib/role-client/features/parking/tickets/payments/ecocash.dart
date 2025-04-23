import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/role-client/features/parking/tickets/functions/tickets_crud.dart';
import 'package:portal/role-client/features/parking/vehicles/models/vehicle_model.dart';

class Ecocash extends StatelessWidget {
  final Map<String, dynamic> ticketData;
  const Ecocash({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context) {
    final TextEditingController ecocashNumberController =
        TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: blackColor.withOpacity(0.5),
      backgroundColor: background1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildEcocash(
          context,
        ),
      ),
    );
  }

  Widget buildEcocash(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "lib/assets/payments/ecocash.png",
          height: 100,
          width: 100,
        ),
        const CustomTextfield(
          labelText: "Enter Ecocash Number",
          labelTextColor: textColor2,
          textInputType: TextInputType.numberWithOptions(
            decimal: false,
            signed: false,
          ),
          maxLength: 10,
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: CustomOutlinedButton(
                    btnLabel: "Cancel", onTap: () => Navigator.pop(context))),
            const Gap(16),
            Expanded(
              child: CustomFilledButton(
                btnLabel: "Verify",
                onTap: () => handleEcocashPayment(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void handleEcocashPayment(
    BuildContext context,
  ) async {
    var ticketsCrud = TicketsCrud();
    DateTime now = DateTime.now();

    VehicleModel vehicle = ticketData["vehicle"];
    int issued_time = int.parse(ticketData["issued_time"]);

    // Prepare ticket data
    var vehicle_id = vehicle.id;
    var issued_length = ticketData["issued_time"];
    var issued_at = now;
    var expiry_at = now.add(Duration(hours: issued_time));
    var amount = ticketData["amount"];

    ticketData["issued_at"] = issued_at;
    ticketData["expiry_at"] = expiry_at;

    try {
      var result = ticketsCrud.submitTicket(
          vehicle_id: vehicle_id,
          issued_length: issued_length,
          issued_at: issued_at,
          expiry_at: expiry_at,
          amount: amount,
          context: context);

      DevLogs.logInfo("Ticket Data: $ticketData");

      context.pop(); // Close the Ecocash dialog
      context.pushNamed(
        "ticket-purchase-successful",
      );
    } catch (e) {
      DevLogs.logError("Error $e");
      CustomSnackbar(message: "Error $e", color: redColor)
          .showSnackBar(context);
    }
  }
}
