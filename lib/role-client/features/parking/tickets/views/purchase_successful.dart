import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/constants/colors/dimensions.dart';

class TicketPurchaseSuccessfulPage extends StatelessWidget {
  const TicketPurchaseSuccessfulPage({super.key});

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
          buildButtonSection()
        ],
      ),
    );
  }

  Widget buildTicketDetails() {
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
          buildRow(title: 'Vehicle', value: "ABC123"),
          buildRow(title: 'City', value: "New York"),
          buildRow(title: 'Issued At', value: "2023-10-01 12:00"),
          buildRow(title: 'Expiry At', value: "2023-10-01 13:00"),
          buildRow(title: 'Amount', value: "\$1.00"),
        ],
      ),
    );
  }

  Widget buildButtonSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomFilledButton(btnLabel: "Back Home", onTap: () {}),
        const Gap(16),
        CustomOutlinedButton(btnLabel: "Buy Another", onTap: () {})
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
