import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/parking/tickets/model/parking_ticket_model.dart';
import 'package:portal/features/parking/tickets/provider/parking_ticket_provider.dart';
import 'package:portal/features/parking/vehicles/components/parking_ticket_card.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';

class VehicleDetail extends ConsumerStatefulWidget {
  final VehicleModel vehicle;
  const VehicleDetail({super.key, required this.vehicle});

  @override
  ConsumerState<VehicleDetail> createState() => _VehicleDetailState();
}

class _VehicleDetailState extends ConsumerState<VehicleDetail> {
  @override
  Widget build(BuildContext context) {
    final allTicketsAsyncValue = ref.watch(allTicketsProvider);
    return allTicketsAsyncValue.when(
      data: (tickets) {
        tickets = tickets
            .where((ticket) => ticket.vehicle == widget.vehicle.id)
            .toList();
        tickets.sort((a, b) => a.expiry_at.compareTo(b.expiry_at));
        if (tickets.isEmpty) {
          return const Center(
            child: Text('No tickets found'),
          );
        } else {
          return Scaffold(
            backgroundColor: background2,
            body: Column(
              children: [
                const SizedBox(height: 16),
                carDetail(),
                const SizedBox(height: 16),
                Expanded(child: ticketSection(tickets: tickets)),
              ],
            ),
          );
        }
      },
      error: (err, stack) {
        CustomSnackbar(
          message: 'Error: $err',
          color: redColor,
        ).showSnackBar(context);
        return const SizedBox();
      },
      loading: () => const CustomCircularProgressIndicator(
        color: textColor2,
      ),
    );
  }

  Widget carDetail() {
    return Stack(
      children: [
        // Car vector shadow image positioned to the right and behind
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            "lib/assets/images/car_vector.png",
            width: 220,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vehicle image
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(uniBorderRadius),
                  child: Image.asset(
                    widget.vehicle.image,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Vehicle info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vehicle.plate_number,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      capitalize(
                          "${widget.vehicle.brand} ${widget.vehicle.model}"),
                      style: const TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                    Text(
                      capitalize(widget.vehicle.vehicle_type),
                      style: const TextStyle(
                        fontSize: 16,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ticketSection({
    required List<ParkingTicketModel> tickets,
  }) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: background1,
        borderRadius: BorderRadius.circular(uniBorderRadius),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Parking Tickets",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor2.withOpacity(0.8),
              ),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildRechargeHistoryTime(),
              const Gap(16),
              ...tickets.map((ticket) {
                return ParkingTicketCard(ticket: ticket);
              }),
              const Gap(16),
            ],
          )),
        ],
      ),
    );
  }

  Widget buildRechargeHistoryTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(uniBorderRadius),
        ),
        child: const Row(
          children: [
            Icon(
              CupertinoIcons.smiley,
              color: primaryColor,
            ),
            Gap(8),
            Text(
              "Ticket history in the past 6 months",
              style: TextStyle(
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
