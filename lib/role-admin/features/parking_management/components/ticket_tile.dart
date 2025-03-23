import 'package:flutter/material.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/utils/string_methods.dart';

class TicketTile extends StatefulWidget {
  final Map<String, dynamic> ticket;
  const TicketTile({super.key, required this.ticket});

  @override
  State<TicketTile> createState() => _TicketTileState();
}

class _TicketTileState extends State<TicketTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildRow(
            Text(
              widget.ticket['vehicle'],
              style: genericStyle(true),
            ),
            Text(
              capitalize(
                widget.ticket['status'],
              ),
              style: getStyle(widget.ticket['status']),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(
                Text(
                  "Time in: ${timeFormatted(widget.ticket['issued_at'])}",
                  style: genericStyle(false),
                ),
                Text("Time out: ${timeFormatted(widget.ticket['expiry_at'])}",
                    style: genericStyle(false)),
              ),
              buildRow(
                Text("Date: ${dateFormatted(DateTime.now())}",
                    style: genericStyle(false)),
                Text('Amount: ${widget.ticket['amount']} USD',
                    style: genericStyle(false)),
              ),
            ],
          ),
        ),
        const Divider(
          color: secondaryColor,
          height: 0,
          thickness: .5,
        ),
      ],
    );
  }

  TextStyle getStyle(String status) {
    if (status == 'active') {
      return const TextStyle(color: primaryColor);
    } else if (status == 'used') {
      return const TextStyle(color: accentColor);
    } else {
      return const TextStyle(color: redColor);
    }
  }

  TextStyle genericStyle(bool bold) {
    return TextStyle(
        color: textColor1,
        overflow: TextOverflow.ellipsis,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }

  Widget buildRow(Widget left, Widget right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [left, right],
    );
  }
}
