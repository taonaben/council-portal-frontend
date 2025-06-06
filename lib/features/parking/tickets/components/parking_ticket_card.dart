import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/cities/providers/cities_providers.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';

class ParkingTicketCard extends ConsumerWidget {
  final ParkingTicketModel ticket;
  const ParkingTicketCard({super.key, required this.ticket});

  /**
   * ticket #
   * amount
   * status
   * city
   * time
   * date
   * duration
   */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uniBorderRadius)),
      elevation: 3,
      color: background1,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shadowColor: blackColor.withOpacity(.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(
                            ClipboardData(text: ticket.ticket_number!))
                        .then((_) {
                      const CustomSnackbar(
                        message: "Copied",
                        color: primaryColor,
                      ).showSnackBar(context);
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.square_on_square),
                      const Gap(8),
                      Text(
                        '#${ticket.ticket_number}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor2,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'USD\$ ${ticket.amount}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const CustomDivider(
              color: textColor2,
            ),
            const Gap(8),
            ticketDetails(ref),
          ],
        ),
      ),
    );
  }

  Widget ticketDetails(WidgetRef ref) {
    final cityAsyncValue = ref.watch(cityByIdProvider(ticket.city!));
    return Column(
      children: [
        buildRow(
          title: 'Status',
          value: capitalize(ticket.status!),
        ),
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
          title: 'Time',
          value:
              '${timeFormatted(ticket.issued_at)} - ${timeFormatted(ticket.expiry_at)}',
        ),
        buildRow(
          title: 'Issued',
          value: timeAgo(ticket.issued_at!),
        ),
        buildRow(
          title: 'Duration',
          value: "${ticket.minutes_issued! / 60} hours",
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
