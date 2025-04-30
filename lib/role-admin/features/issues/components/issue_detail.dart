import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_filled_btn.dart';
import 'package:portal/constants/colors.dart';

class IssueDetail extends StatefulWidget {
  final Map<String, dynamic> issue;
  const IssueDetail({super.key, required this.issue});

  @override
  State<IssueDetail> createState() => _IssueDetailState();
}

class _IssueDetailState extends State<IssueDetail> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: background2,
          border: Border.all(color: textColor1, width: .2),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildHeader(),
            const CustomDivider(),
            buildBody(),
            buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.issue['reported_by']} • +263781830006",
                style: const TextStyle(color: textColor1)),
            const Gap(8),
            Text(widget.issue['created_at'],
                style: const TextStyle(color: secondaryColor)),
          ],
        ),
        Tooltip(
          message: 'Close',
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.clear, color: textColor1)),
        ),
      ],
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.issue['category'],
            style: const TextStyle(
                color: textColor1, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(widget.issue['description'],
            style: const TextStyle(color: textColor1)),
      ],
    );
  }

  Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStatusBtn(widget.issue['status']),
        // const Gap(8),
        CustomFilledButton(
            btnLabel: 'Save',
            onTap: () {
              Navigator.pop(context);
            }),
      ],
    );
  }

  Widget buildStatusBtn(String status) {
    return Tooltip(
      message: 'Change status',
      child: DropdownButton<String>(
        value: status,
        icon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            CupertinoIcons.chevron_down,
            color: primaryColor,
            size: 16,
          ),
        ),
        underline: const SizedBox(),
        elevation: 1,
        dropdownColor: background2,
        borderRadius: BorderRadius.circular(20),
        style: const TextStyle(color: primaryColor),
        items: const [
          DropdownMenuItem(
            value: 'active',
            child: Text('Active'),
          ),
          DropdownMenuItem(
            value: 'pending',
            child: Text('Pending'),
          ),
          DropdownMenuItem(
            value: 'resolved',
            child: Text('Resolved'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            widget.issue['status'] = value!;
          });
        },
      ),
    );
  }
}
