import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/constants/colors/dimensions.dart';

class TicketsMainClient extends StatefulWidget {
  const TicketsMainClient({super.key});

  @override
  State<TicketsMainClient> createState() => _TicketsMainClientState();
}

class _TicketsMainClientState extends State<TicketsMainClient> {
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildHeader(context),
          const Gap(16),
          buildQuickChoicesSection(context),
          buildRechargeTime(),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
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

  Widget buildSelectRecipient() {
    return Row(
      children: [
        Expanded(
          child: buildBtn(text: "Buy For Me", isSelected: true),
        ),
        const Gap(4),
        Expanded(
          child: buildBtn(text: "Buy For Other", isSelected: false),
        ),
      ],
    );
  }

  Widget buildBtn({required String text, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? background2 : secondaryColor,
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: textColor1,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildQuickChoicesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Quick Select',
            style: TextStyle(
              color: textColor2,
              fontWeight: FontWeight.w500,
            )),
        const Gap(9),
        SizedBox(
          // height: 350, // Adjust this value based on your needs
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 2, // Adjust this value to control button height
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
                  });
                },
                child: buildTicketCard(
                  time: option['time'],
                  price: option['price'],
                  unit: option['unit'],
                  isSelected: option['isSelected'],
                ),
              );
            },
          ),
        ),
      ],
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
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter time",
                  hintStyle: const TextStyle(color: textColor2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const Gap(8),
            const Text("\$0.50",
                style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        const CustomDivider(color: textColor2),
        const Gap(8),
        const Text("Total time: 1 hour",
            style: const TextStyle(
              color: textColor2,
            )),
        const Text("Total cost: \$1",
            style: const TextStyle(
              color: textColor2,
            )),
        const Gap(16),
        buildSelectRecipient(),
      ],
    );
  }

  List<Map<String, dynamic>> options = [
    {
      "time": 1,
      "price": 1,
      "unit": "hour",
      "isSelected": true,
    },
    {
      "time": 2,
      "price": 4,
      "unit": "hours",
      "isSelected": false,
    },
    {
      "time": 3,
      "price": 6.5,
      "unit": "hours",
      "isSelected": false,
    },
    {
      "time": 1,
      "price": 20,
      "unit": "day",
      "isSelected": false,
    }
  ];

  Widget buildTicketCard({
    required int time,
    required double price,
    required String unit,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? background2 : secondaryColor,
            width: 2,
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            "$time $unit",
            style: const TextStyle(
              color: primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "\$$price",
            style: const TextStyle(
              color: textColor2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
      ),
    );
  }
}
