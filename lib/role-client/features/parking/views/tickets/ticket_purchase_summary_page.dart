import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/assets/images/logo_urls.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/constants/colors/dimensions.dart';
import 'package:portal/core/payments/bank_transfer.dart';
import 'package:portal/core/payments/ecocash.dart';
import 'package:portal/core/payments/mastercard.dart';
import 'package:portal/core/payments/omari.dart';
import 'package:portal/core/payments/onemoney.dart';
import 'package:portal/core/payments/visa.dart';

class TicketPurchaseSummaryPage extends StatefulWidget {
  const TicketPurchaseSummaryPage({super.key});

  @override
  State<TicketPurchaseSummaryPage> createState() =>
      _TicketPurchaseSummaryPageState();
}

class _TicketPurchaseSummaryPageState extends State<TicketPurchaseSummaryPage> {
  PaymentMethod? _selectedPayment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(),
        const Gap(16),
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const Text("Select Payment Method",
              style: TextStyle(
                  color: secondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
        const Gap(16),
        Expanded(child: SingleChildScrollView(child: buildBody())),
        buildFooter()
      ],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: background1,
          borderRadius: BorderRadius.circular(uniBorderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(
                  backgroundColor: background2,
                  child: Icon(
                    Icons.directions_car_filled_outlined,
                    color: textColor1,
                  )),
              title: Text("Honda Civic Type R"),
              subtitle: Text(
                "AFE 8044",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const CustomDivider(
              color: secondaryColor,
              isBroken: true,
            ),
            const Text("Your Order", style: TextStyle(color: secondaryColor)),
            const Gap(16),
            boughtTicketCard(),
          ],
        ),
      ),
    );
  }

  Widget boughtTicketCard() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("1 Hour",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(
          "USD\$ 1.34",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        )
      ],
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildPaymentSection(),
    );
  }

  Widget buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background1,
        borderRadius: BorderRadius.circular(uniBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: PaymentMethod.values.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final method = PaymentMethod.values[index];
          return buildPaymentOption(method);
        },
      ),
    );
  }

  Widget buildPaymentOption(PaymentMethod method) {
    final bool isSelected = _selectedPayment == method;

    return InkWell(
      onTap: () => setState(() => _selectedPayment = method),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: background1,
          borderRadius: BorderRadius.circular(uniBorderRadius),
          border: Border.all(
            color: isSelected ? primaryColor : background2,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                PaymentAssets.logos[method]!,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Error loading image for ${method.name}: $error');
                  return const Icon(Icons.payment, size: 30);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                PaymentAssets.names[method]!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(CupertinoIcons.check_mark, color: background2),
          ],
        ),
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background1,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, -4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total"),
              Text(
                "USD\$ 1.34",
                style: TextStyle(
                    color: redColor, fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
          Spacer(),
          Expanded(
            child: CustomFilledButton(
              btnLabel: 'Buy',
              onTap: _selectedPayment == null ? null : () => _handlePayment(),
              expand: true,
              textColor: textColor1,
              backgroundColor: _selectedPayment == null
                  ? background2.withOpacity(0.5)
                  : background2,
            ),
          )
        ],
      ),
    );
  }

  final Map<PaymentMethod, Widget Function(BuildContext)> _paymentDialogs = {
    PaymentMethod.ecocash: (context) => const Ecocash(),
    PaymentMethod.oneMoney: (context) => const Onemoney(),
    PaymentMethod.bankTransfer: (context) => const BankTransfer(),
    PaymentMethod.masterCard: (context) => const Mastercard(),
    PaymentMethod.visa: (context) => const Visa(),
    PaymentMethod.omari: (context) => const Omari(),
  };

  void _handlePayment() {
    if (_selectedPayment == null) return;

    final dialogBuilder = _paymentDialogs[_selectedPayment];
    if (dialogBuilder != null) {
      showDialog(
        context: context,
        builder: dialogBuilder,
      );
    } else {
      debugPrint('No payment method selected');
    }
  }
}
