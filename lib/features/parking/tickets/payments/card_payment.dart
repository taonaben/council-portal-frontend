import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/core/utils/logs.dart';
import 'package:portal/features/parking/tickets/functions/tickets_crud.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';

class CardPayment extends StatelessWidget {
  final Map<String, dynamic>? ticketData;
  const CardPayment({super.key,  this.ticketData});

  @override
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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Expanded(
                child: buildCardPayment(
                  context,
                ),
              ),
              const Gap(16),
              buildCardPaymentButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardPayment(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "lib/assets/payments/card.png",
            height: 100,
            width: 100,
          ),
          const CustomTextfield(
            labelText: "Card information",
            labelTextColor: textColor2,
            textInputType: TextInputType.numberWithOptions(
              decimal: false,
              signed: false,
            ),
            maxLength: 16,
          ),
          const Row(
            children: [
              Expanded(
                child: CustomTextfield(
                  labelText: "Expiry",
                  hintText: 'MM/YY',
                  labelTextColor: textColor2,
                  textInputType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  maxLength: 4,
                ),
              ),
              Gap(8),
              Expanded(
                child: CustomTextfield(
                  labelText: "CVV",
                  hintText: 'CVV',
                  labelTextColor: textColor2,
                  textInputType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  maxLength: 3,
                ),
              ),
            ],
          ),
          const CustomTextfield(
            labelText: "Name on card",
            labelTextColor: textColor2,
          ),
          const Gap(16),
          const Text(
            "Billing Address",
            style: TextStyle(
              color: textColor2,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const CustomTextfield(
            labelText: "Country",
            labelTextColor: textColor2,
            hintText: "Country",
          ),
          const CustomTextfield(
            labelText: "Address Line 1",
            labelTextColor: textColor2,
            hintText: "Street address, P.O. box, etc.",
          ),
          const CustomTextfield(
            labelText: "Address Line 2",
            labelTextColor: textColor2,
            hintText: "Apartment, suite, unit, building, floor, etc.",
          ),
          const Row(
            children: [
              Expanded(
                child: CustomTextfield(
                  labelText: "City",
                  labelTextColor: textColor2,
                  hintText: "City",
                ),
              ),
              Gap(8),
              Expanded(
                child: CustomTextfield(
                  labelText: "Postal Code",
                  labelTextColor: textColor2,
                  hintText: "Postal Code",
                ),
              ),
            ],
          ),
          const CustomTextfield(
            labelText: "State",
            labelTextColor: textColor2,
            hintText: "State/Province/Region",
          ),
        ],
      ),
    );
  }

  Widget buildCardPaymentButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: CustomOutlinedButton(
                btnLabel: "Cancel", onTap: () => Navigator.pop(context))),
        const Gap(16),
        Expanded(
            child: CustomFilledButton(
                btnLabel: "Continue",
                onTap: () {
                  handleCardPayment(context);
                })),
      ],
    );
  }

  void handleCardPayment(BuildContext context) async {
    var ticketsCrud = TicketsCrud();

    VehicleModel vehicle = ticketData?["vehicle"];

    // Prepare ticket data
    var vehicleId = vehicle.id;
    int issuedMinutes = ticketData?["issued_minutes"];

    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CustomCircularProgressIndicator(color: textColor2),
              ));

      var result = await ticketsCrud.submitTicket(
          vehicleId: vehicleId!,
          issuedMinutes: issuedMinutes,
          context: context);

      DevLogs.logInfo("Ticket Data: $ticketData");

      if (result != null) {
        // context.pop(); // Close the Ecocash dialog
        context.pushReplacementNamed(
          "ticket-purchase-successful",
          extra: result,
        );
      }

      Navigator.pop(context);
    } catch (e) {
      DevLogs.logError("Error $e");
      CustomSnackbar(message: "Error $e", color: redColor)
          .showSnackBar(context);
    }
  }
}
