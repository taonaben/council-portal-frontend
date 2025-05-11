import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/assets/images/logo_urls.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_outlined_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/components/widgets/custom_textfield.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/features/parking/tickets/payments/bank_transfer.dart';
import 'package:portal/features/parking/tickets/payments/card_payment.dart';
import 'package:portal/features/parking/tickets/payments/ecocash.dart';
import 'package:portal/features/parking/tickets/payments/onemoney.dart';
import 'package:portal/features/water/model/water_bill_model.dart';

class PayWaterBill extends StatefulWidget {
  final WaterBillModel waterBill;
  const PayWaterBill({super.key, required this.waterBill});

  @override
  State<PayWaterBill> createState() => _PayWaterBillState();
}

class _PayWaterBillState extends State<PayWaterBill> {
  TextEditingController amountController = TextEditingController();
  PaymentMethod? _selectedPayment;

  late final Map<PaymentMethod,
          Widget Function(BuildContext, Map<String, dynamic> ticketData)>
      _paymentDialogs;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    amountController.text = widget.waterBill.total_amount.toString();
    _paymentDialogs = {
      PaymentMethod.ecocash: (context, ticketData) => const EcoCash(
            purchasedItem: ItemPurchased.water,
          ),
      PaymentMethod.oneMoney: (context, ticketData) => Onemoney(),
      PaymentMethod.bankTransfer: (context, ticketData) => BankTransfer(),
      PaymentMethod.card: (context, ticketData) => CardPayment(),
    };
  }

  void _handlePayment() {
    if (_selectedPayment == null) return;

    final dialogBuilder = _paymentDialogs[_selectedPayment];
    if (dialogBuilder != null) {
      showDialog(
        context: context,
        builder: (context) =>
            dialogBuilder(context, {"amount": amountController.text}),
      );
    } else {
      debugPrint('No payment method selected');
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      shadowColor: blackColor.withOpacity(0.5),
      backgroundColor: background2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildPaymentMethodSelector(),
              const Gap(8),
              CustomTextfield(
                labelText: "Enter Amount-USD",
                hintText: "Enter Amount",
                controller: amountController,
                validator: (p0) => p0!.isEmpty
                    ? "Please enter the amount"
                    : double.tryParse(p0) == null
                        ? "Please enter a valid amount"
                        : null,
              ),
              const Gap(16),
              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      btnLabel: "Cancel",
                      borderColor: secondaryColor,
                      backgroundColor: background2,
                      textColor: textColor1,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: CustomFilledButton(
                      btnLabel: "Pay",
                      backgroundColor: _selectedPayment == null
                          ? secondaryColor
                          : primaryColor,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (_selectedPayment == null) {
                            const CustomSnackbar(
                                    message: "Select payment method",
                                    color: redColor)
                                .showSnackBar(context);
                          } else {
                            Navigator.pop(context);

                            _handlePayment();
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentMethodSelector() {
    final paymentMethods = [
      {
        'image': "lib/assets/payments/ecocash.png",
        'method': PaymentMethod.ecocash
      },
      {
        'image': "lib/assets/payments/onemoney.jpg",
        'method': PaymentMethod.oneMoney
      },
      {
        'image': "lib/assets/payments/bank.png",
        'method': PaymentMethod.bankTransfer
      },
      {'image': "lib/assets/payments/card.png", 'method': PaymentMethod.card},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: paymentMethods.map((payment) {
        final isSelected = _selectedPayment == payment['method'];
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedPayment = payment['method'] as PaymentMethod;
            });
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(uniBorderRadius),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.transparent,
                width: isSelected ? 2 : 1,
              ),
              image: DecorationImage(
                image: AssetImage(payment['image'] as String),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
