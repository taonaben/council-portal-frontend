import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/role-admin/features/issues/components/issue_detail.dart';

class IssuesCard extends StatefulWidget {
  final Map<String, dynamic> issue;
  const IssuesCard({super.key, required this.issue});

  @override
  State<IssuesCard> createState() => _IssuesCardState();
}

class _IssuesCardState extends State<IssuesCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.issue['category'],
            style: const TextStyle(color: textColor1),
          ),
          subtitle: Text(widget.issue['description'],
              style: const TextStyle(color: secondaryColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          trailing: buildStatusBtn(widget.issue['status']),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => IssueDetail(issue: widget.issue),
            );
          },
        ),
        const Divider(
          color: secondaryColor,
          height: 0,
          thickness: .5,
        ),
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
