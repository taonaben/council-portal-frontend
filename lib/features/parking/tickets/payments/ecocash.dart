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
import 'package:portal/features/parking/tickets/api/ticket_list.dart';
import 'package:portal/features/parking/tickets/functions/tickets_crud.dart';
import 'package:portal/features/parking/tickets/services/ticket_bundle_services.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';

enum ItemPurchased { ticket, bundle, water }

class EcoCash extends StatelessWidget {
  final Map<String, dynamic>? ticketData;
  final Map<String, dynamic>? bundleData;
  final ItemPurchased purchasedItem;
  const EcoCash(
      {super.key, this.ticketData,required this.purchasedItem, this.bundleData});

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
                  onTap: () => processEcocashPayment(context)),
            ),
          ],
        ),
      ],
    );
  }

  processEcocashPayment(BuildContext context) async {
    switch (purchasedItem) {
      case ItemPurchased.ticket:
        await handleTicketPayment(context);
        break;
      case ItemPurchased.bundle:
        await handleBundlePayment(context);
        break;
      case ItemPurchased.water:
        await handleWaterPayment(context);
        break;
      default:
        null;
    }
  }

  

  handleBundlePayment(BuildContext context) async {
    var bundleServices = TicketBundleServices();

    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CustomCircularProgressIndicator(color: textColor2),
              ));

      var result = await bundleServices.purchaseBundle(
        bundleData!["quantity"],
        bundleData!["ticket_minutes"],
        bundleData!["price"], // Default to 0.0 if null
      );

      if (result) {
        Navigator.pop(context);
        const CustomSnackbar(
                message: "Bundle purchased successfully", color: primaryColor)
            .showSnackBar(context);

        context.pushReplacementNamed("bundle-purchase-successful",
            extra: bundleData);
      } else {
        Navigator.pop(context);
        CustomSnackbar(message: "Error purchasing bundle", color: redColor)
            .showSnackBar(context);
      }
    } catch (e) {
      DevLogs.logError("Error $e");
      CustomSnackbar(message: "Error $e", color: redColor)
          .showSnackBar(context);
    }
  }

  handleTicketPayment(
    BuildContext context,
  ) async {
    var ticketsCrud = TicketsCrud();

    VehicleModel vehicle = ticketData!["vehicle"];

    // Prepare ticket data
    var vehicleId = vehicle.id;
    int issuedMinutes = ticketData!["issued_minutes"];

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
