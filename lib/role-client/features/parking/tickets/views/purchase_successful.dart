import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/constants/colors/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/role-client/features/parking/vehicles/models/vehicle_model.dart';

class TicketPurchaseSuccessfulPage extends StatelessWidget {
  final Map<String, dynamic> ticketData;
  const TicketPurchaseSuccessfulPage({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'lib/assets/images/checkmark_2.png',
            width: MediaQuery.of(context).size.height * 0.3,
            height: MediaQuery.of(context).size.height * 0.3,
            color: primaryColor,
          ),
          const Gap(16),
          const Text('Purchase Successful',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const Gap(16),
          buildTicketDetails(),
          const Gap(32),
          buildButtonSection(context)
        ],
      ),
    );
  }

  Widget buildTicketDetails() {
    VehicleModel vehicle = ticketData["vehicle"];

    // Prepare ticket data
    var plate_number = vehicle.plate_number;

    var issued_length = ticketData["issued_length"];
    var issued_at = ticketData["issued_at"];
    var expiry_at = ticketData["expiry_at"];
    var amount = ticketData["amount"];
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildRow(title: 'Ticket Number', value: "123456"),
          buildRow(title: 'Vehicle', value: plate_number),
          buildRow(title: 'City', value: "New York"),
          buildRow(title: 'Issued At', value: dateTimeFormatted(issued_at)),
          buildRow(title: 'Expiry At', value: dateTimeFormatted(expiry_at)),
          buildRow(title: 'Amount', value: "USD\$$amount"),
        ],
      ),
    );
  }

  Widget buildButtonSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFilledButton(
          btnLabel: "Back Home",
          onTap: () {
            while (context.canPop()) {
              context.pop();
            }
            context.pushReplacement(
              '/client/parking',
            );
          },
        ),
      ],
    );
  }

  Widget buildRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
        ),
        Text(
          value,
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
