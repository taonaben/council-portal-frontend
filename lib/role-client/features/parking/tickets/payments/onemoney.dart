import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors/colors.dart';

class Onemoney extends StatelessWidget {
  final Map<String, dynamic> ticketData;
  const Onemoney({super.key, required this.ticketData});

  @override
  Widget build(BuildContext context) {
    final TextEditingController oneMoneyNumberController =
        TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor:  blackColor.withOpacity(0.5),
      backgroundColor: background1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildOneMoney(
          context,
        ),
      ),
    );
  }

  Widget buildOneMoney(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          "lib/assets/payments/onemoney.jpg",
          height: 100,
          width: 100,
        ),
        const CustomTextfield(
          labelText: "Enter OneMoney Number",
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
                child: CustomFilledButton(btnLabel: "Verify", onTap: () {}))
          ],
        ),
      ],
    );
  }

  void handleOneMoneyPayment(BuildContext context) {}
}
