import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors/colors.dart';

class Ecocash extends StatelessWidget {
  const Ecocash({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController ecocashNumberController =
        TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: secondaryColor,
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
                child: CustomFilledButton(btnLabel: "Verify", onTap: () {}))
          ],
        ),
      ],
    );
  }

  void handleEcocashPayment(BuildContext context) {}
}
