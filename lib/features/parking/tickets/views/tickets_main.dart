import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/features/parking/vehicles/models/vehicle_model.dart';
import 'package:flutter/services.dart';

class TicketsMainClient extends StatefulWidget {
  final VehicleModel vehicle;
  const TicketsMainClient({super.key, required this.vehicle});

  @override
  State<TicketsMainClient> createState() => _TicketsMainClientState();
}

class _TicketsMainClientState extends State<TicketsMainClient> {
  final TextEditingController timeController = TextEditingController();
  double pricePerHr = 1;

  @override
  void initState() {
    super.initState();
    timeController.text = "1";
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> options = [
    {
      "time": 1,
      "unit": "hour",
      "isSelected": true,
    },
    {
      "time": 2,
      "unit": "hours",
      "isSelected": false,
    },
    {
      "time": 3,
      "unit": "hours",
      "isSelected": false,
    },
    {
      "time": 4,
      "unit": "hours",
      "isSelected": false,
    }
  ];

  double calculateTotalCost() {
    double totalCost = 0.0;

    if (timeController.text.isEmpty) {
      return totalCost;
    }

    try {
      totalCost = double.parse(timeController.text) * pricePerHr;
    } on FormatException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid input. Please enter a valid number.',
          ),
        ),
      );
    }

    return double.parse(totalCost.toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Ticket"),
        centerTitle: true,
        backgroundColor: background1,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildHeader(context),
              const Gap(16),
              buildQuickChoicesSection(context),
              const Gap(16),
              buildRechargeTime(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Duration",
          style: TextStyle(
            color: textColor2,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildTicketCard({
    required int time,
    required double price,
    required String unit,
    required bool isSelected,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? background2 : background1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? background2 : secondaryColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isSelected ? 0.15 : 0.25),
            offset: Offset(0, isSelected ? 2 : 4),
            blurRadius: isSelected ? 2 : 8,
            spreadRadius: isSelected ? 1 : 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                "$time $unit",
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            FittedBox(
              child: Text(
                "\$${price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: isSelected ? textColor1 : textColor2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuickChoicesSection(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 400;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Select',
              style: TextStyle(
                color: textColor2,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isSmallScreen ? 1.6 : 2,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (var i = 0; i < options.length; i++) {
                        options[i]['isSelected'] = i == index;
                      }
                      timeController.text = option['time'].toString();
                    });
                  },
                  child: buildTicketCard(
                    time: option['time'],
                    price: option['time'] * pricePerHr,
                    unit: option['unit'],
                    isSelected: option['isSelected'],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildRechargeTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Recharge Time",
          style: TextStyle(
            color: textColor2,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80, // adjust width as needed
                child: TextFormField(
                  controller: timeController,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  style: const TextStyle(
                    color: textColor2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    setState(() {
                      // Updates the selected time based on user input
                      for (var option in options) {
                        option['isSelected'] =
                            option['time'].toString() == value;
                      }
                    });
                  },
                ),
              ),
              const Gap(8),
              Text(
                timeController.text.isNotEmpty &&
                        int.parse(timeController.text) < 2
                    ? 'hour'
                    : 'hours',
                style: const TextStyle(
                  color: textColor2,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const CustomDivider(color: textColor2),
        const Gap(8),
        Text(
            "Total Time: ${timeController.text} ${timeController.text.isNotEmpty && int.parse(timeController.text) < 2 ? 'hour' : 'hours'}",
            style: const TextStyle(
              color: textColor2,
            )),
        Text("Total cost: \$${calculateTotalCost()}",
            style: const TextStyle(
              color: textColor2,
            )),
        const Gap(16),
        buildSelectRecipient(),
      ],
    );
  }

  bool checkTicketValidity() {
    if (timeController.text.isEmpty) {
      return false;
    }

    if (double.parse(timeController.text) < 1) {
      return false;
    }

    return true;
  }

  Widget buildSelectRecipient() {
    Map<String, dynamic> ticketData = {
      "vehicle": widget.vehicle,
      "issued_time": timeController.text.toString(),
      "issued_at": null,
      "expiry_at": null,
      "amount": calculateTotalCost()
    };
    return Column(
      children: [
        Row(
          children: [
            // Expanded(
            //   child: buildRecipientBtn(text: "Buy For Me", isSelected: true),
            // ),
            Expanded(
                child: CustomFilledButton(
              btnLabel: "Buy For Me",
              onTap: () => checkTicketValidity() == false
                  ? null
                  : context.pushNamed("parking-ticket-purchase-summary",
                      extra: ticketData),
              expand: true,
              backgroundColor: checkTicketValidity() == false
                  ? background2.withOpacity(0.5)
                  : background2,
              textColor: textColor1,
            )),
            const Gap(4),
            Expanded(
                child: CustomFilledButton(
              btnLabel: "Buy For Other",
              onTap: () => checkTicketValidity() == false
                  ? null
                  : context.pushNamed("buy-parking-for-other",
                      extra: ticketData),
              expand: true,
              backgroundColor: checkTicketValidity() == false
                  ? secondaryColor.withOpacity(0.5)
                  : secondaryColor,
              textColor: textColor1,
            )),
          ],
        ),
        const Gap(8),
        CustomOutlinedButton(
          btnLabel: "Cancel",
          onTap: () => context.pop(),
          expand: true,
          borderColor: background2,
        )
      ],
    );
  }
}
