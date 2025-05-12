import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/cities/providers/cities_providers.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';
import 'package:portal/features/parking/vehicles/provider/vehicle_provider.dart';

class TicketPurchaseSuccessfulPage extends ConsumerWidget {
  final ParkingTicketModel ticketData;
  const TicketPurchaseSuccessfulPage({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
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
            buildTicketDetails(ref),
            const Gap(32),
            buildButtonSection(context)
          ],
        ),
      ),
    );
  }

  Widget buildTicketDetails(WidgetRef ref) {
    final cityAsyncValue = ref.watch(cityByIdProvider(ticketData.city!));
    final vehicleAsyncValue = ref.watch(activeVehicleProvider);

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
          buildRow(title: 'Ticket Number', value: ticketData.ticket_number!),
          buildRow(
              title: 'Vehicle',
              value: vehicleAsyncValue.when(
                data: (vehicle) {
                  return vehicle?.plate_number.toUpperCase() ??
                      'No vehicle found';
                },
                loading: () => 'Loading...',
                error: (error, stack) => 'Error fetching vehicle',
              )),
          buildRow(
            title: 'City',
            value: cityAsyncValue.when(
              data: (city) {
                return city?.name.toLowerCase() ?? 'No city found';
              },
              loading: () => 'Loading...',
              error: (error, stack) => 'Error fetching city',
            ),
          ),
          buildRow(
              title: 'Issued At',
              value: dateTimeFormatted(ticketData.issued_at)),
          buildRow(
              title: 'Expiry At',
              value: dateTimeFormatted(ticketData.expiry_at)),
          buildRow(title: 'Amount', value: "USD\$${ticketData.amount}"),
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
              '/home/1',
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
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
