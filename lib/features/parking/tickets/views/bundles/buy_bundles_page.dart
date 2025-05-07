import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';

class BuyBundlesPage extends StatefulWidget {
  const BuyBundlesPage({super.key});

  @override
  State<BuyBundlesPage> createState() => _BuyBundlesPageState();
}

class _BuyBundlesPageState extends State<BuyBundlesPage> {
  Map<String, dynamic> selectedBundle = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Bundles'),
        centerTitle: true,
        backgroundColor: background1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: getBundles().length,
              itemBuilder: (context, index) {
                final bundle = getBundles()[index];
                return buildBundleOption(bundle);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomFilledButton(
                btnLabel: "Purchase",
                onTap: () => {
                      if (selectedBundle.isNotEmpty)
                        {
                          context.pushNamed(
                            "select-bundle-payment",
                            extra: selectedBundle,
                          )
                        }
                      else
                        {
                          // Show a message to select a bundle first
                          const CustomSnackbar(
                                  message: "Please select a bundle first.",
                                  color: redColor)
                              .showSnackBar(context),
                        }
                    }),
          ),
        ],
      ),
    );
  }

  Widget buildBundleOption(Map<String, dynamic> bundle) {
    final isSelected = selectedBundle == bundle;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBundle = bundle;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(uniBorderRadius),
          side: BorderSide(
            color: isSelected ? primaryColor : Colors.transparent,
            width: 2,
          ),
        ),
        elevation: 3,
        color: background1,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shadowColor: blackColor.withOpacity(.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(title: "Bundle", value: "${bundle["quantity"]} tickets"),
              const CustomDivider(
                color: textColor2,
              ),
              buildRow(
                  title: "Ticket Minutes",
                  value: "${bundle["ticket_minutes"]} minutes"),
              const Gap(8),
              buildRow(title: "Price", value: "USD \$${bundle["price"]}"),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> getBundles() {
    return [
      {
        "quantity": 25,
        "ticket_minutes": 60,
        "price": 22.0,
      },
      {
        "quantity": 50,
        "ticket_minutes": 60,
        "price": 42.0,
      },
      {
        "quantity": 100,
        "ticket_minutes": 60,
        "price": 78.0,
      },
      
    ].map((bundle) {
      bundle["price"] = bundle["price"] ?? 0.0; // Ensure price is not null
      return bundle;
    }).toList();
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
