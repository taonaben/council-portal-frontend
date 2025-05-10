import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/water/model/water_bill_model.dart';

class WaterBill extends StatelessWidget {
  final WaterBillModel waterBill;
  const WaterBill({super.key, required this.waterBill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          buildHeader(),
          const Gap(8),
          buildChargesSection(),
          const Gap(8),
          buildDebtsTable(),
          const Gap(8),
          buildSummariesSection(),
          const Gap(8),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        buildRow(title: "Bill Number", value: waterBill.bill_number),
        buildRow(
            title: "Account Date",
            value: dateFormatted(waterBill.billing_period!.bill_date)),
        buildRow(
            title: "Last Receipt Date",
            value: dateFormatted(waterBill.billing_period!.last_receipt_date)),
        buildRow(
            title: "Due Date",
            value: dateFormatted(waterBill.billing_period!.due_date)),
        const Gap(8),
        const CustomDivider(
          isBroken: true,
          color: textColor2,
        )
      ],
    );
  }

  Widget buildChargesSection() {
    return Column(
      children: [
        buildRow(title: "rates", value: waterBill.charges!.rates),
        buildRow(
            title:
                "water (${waterBill.water_usage!.previous_reading} - ${waterBill.water_usage!.current_reading} = ${waterBill.water_usage!.consumption}m³)",
            value: waterBill.charges!.water_charges),
        buildRow(title: "sewerage", value: waterBill.charges!.sewerage),
        buildRow(
            title: "street lighting",
            value: waterBill.charges!.street_lighting),
        buildRow(
            title: "roads charges", value: waterBill.charges!.roads_charge),
        buildRow(
            title: "Education levy", value: waterBill.charges!.education_levy),
        const Gap(8),
      ],
    );
  }

  Widget buildDebtsTable() {
    return Center(
      child: Table(
        border: TableBorder.all(
          color: textColor2,
          style: BorderStyle.solid,
          width: 1,
          borderRadius: BorderRadius.circular(uniBorderRadius),
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        // columnWidths: const {
        //   0: FixedColumnWidth(100),
        //   1: FixedColumnWidth(100),
        //   2: FixedColumnWidth(100),
        // },
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: textColor2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(uniBorderRadius),
                topRight: Radius.circular(uniBorderRadius),
              ),
            ),
            children: const [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "90+",
                      style: TextStyle(color: textColor1),
                      textAlign: TextAlign.center,
                    ),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "60",
                      style: TextStyle(color: textColor1),
                      textAlign: TextAlign.center,
                    ),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "30",
                      style: TextStyle(color: textColor1),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
          TableRow(
            children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      waterBill.water_debt!.over_90_days.toString(),
                      textAlign: TextAlign.center,
                    ),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      waterBill.water_debt!.over_60_days.toString(),
                      textAlign: TextAlign.center,
                    ),
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      waterBill.water_debt!.over_30_days.toString(),
                      textAlign: TextAlign.center,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSummariesSection() {
    return Column(
      children: [
        const Gap(8),
        const CustomDivider(
          isBroken: true,
          color: textColor2,
        ),
        const Gap(8),
        buildRow(title: "balance B/F", value: waterBill.water_debt!.total_debt),
        buildRow(title: "credit", value: waterBill.credit),
        buildRow(title: "current", value: waterBill.charges!.total_due),
        buildRow(
            title: 'Amount Due', value: waterBill.total_amount, isBold: true),
        buildRow(title: "amount paid", value: waterBill.amount_paid),
        buildRow(title: "remaining Balance", value: waterBill.remaining_balance)
      ],
    );
  }

  Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: CustomFilledButton(
            btnLabel: "Account History",
            onTap: () {},
            backgroundColor: secondaryColor,
          ),
        ),
        const Gap(8),
        Expanded(
          child: CustomFilledButton(
            btnLabel: "Pay Now",
            onTap: () {},
          ),
        )
      ],
    );
  }

  Widget buildRow(
      {required String title, required dynamic value, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          capitalize(title),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor2,
          ),
        ),
        Text(
          value is double ? value.toStringAsFixed(2) : value.toString(),
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor2,
          ),
        ),
      ],
    );
  }
}
