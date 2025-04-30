import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/role-admin/features/issues/components/issue_detail.dart';
import 'package:portal/role-admin/features/issues/components/issues_card.dart';

String _loremIpsum() {
  return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.';
}

List<Map<String, dynamic>> issues = [
  {
    'id': '1',
    'reported_by': 'John Doe',
    'category': 'Category 1',
    'description': _loremIpsum(),
    'status': 'pending',
    'created_at': '2023-08-01'
  },
  {
    'id': '2',
    'reported_by': 'John Doe',
    'category': 'Category 2',
    'description': _loremIpsum(),
    'status': 'active',
    'created_at': '2023-08-01'
  },
  {
    'id': '3',
    'reported_by': 'John Doe',
    'category': 'Category 3',
    'description': _loremIpsum(),
    'status': 'resolved',
    'created_at': '2023-08-01'
  },
  {
    'id': '4',
    'reported_by': 'John Doe',
    'category': 'Category 4',
    'description': _loremIpsum(),
    'status': 'pending',
    'created_at': '2023-08-01'
  },
];

class IssuesMain extends StatefulWidget {
  const IssuesMain({super.key});

  @override
  State<IssuesMain> createState() => _IssuesMainState();
}

class _IssuesMainState extends State<IssuesMain> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: background2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            buildHeader(),
            const Gap(8),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return buildResponsiveSmallView();
                  } else {
                    return buildTableView();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildSummaryText('Pending', 2),
        const Gap(16),
        buildSummaryText('Active', 1),
        const Gap(16),
        buildSummaryText('Resolved', 1),
      ],
    );
  }

  Widget buildSummaryText(String text, int value) {
    Color textColor;

    switch (text.toLowerCase()) {
      case 'pending':
        textColor = redColor;
        break;
      case 'active':
        textColor = Colors.orange;
        break;
      case 'resolved':
        textColor = primaryColor;
        break;
      default:
        textColor = primaryColor;
    }

    return Tooltip(
      message: 'Filter ${text.toLowerCase()} issues',
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.w900, fontSize: 40),
            ),
            const Gap(4),
            Text(
              text,
              style: const TextStyle(color: textColor1, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTableView() {
    return Table(
      border: null,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(4),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(2),
      },
      children: [
        buildTableHeader(),
        for (var issue in issues) buildTableRow(issue),
      ],
    );
  }

  TableRow buildTableHeader() {
    return TableRow(
      children: [
        buildCheckBox(false),
        tableCell('Reported By', true),
        tableCell('Category', true),
        tableCell('Description', true),
        tableCell('Status', true),
        tableCell('Reported', true),
      ],
    );
  }

  TableRow buildTableRow(Map<String, dynamic> issue) {
    return TableRow(
      children: [
        GestureDetector(
          onTap: () => onRowTap(issue),
          child: buildCheckBox(false),
        ),
        GestureDetector(
          onTap: () => onRowTap(issue),
          child: tableCell(issue['reported_by'], false),
        ),
        GestureDetector(
          onTap: () => onRowTap(issue),
          child: tableCell(issue['category'], false),
        ),
        GestureDetector(
          onTap: () => onRowTap(issue),
          child: tableCell(issue['description'], false),
        ),
        GestureDetector(
          onTap: () => onRowTap(issue),
          child: buildStatusBadge(issue['status'].toLowerCase()),
        ),
        GestureDetector(
          onTap: () => onRowTap(issue),
          child: tableCell(issue['created_at'], false),
        ),
      ],
    );
  }

  void onRowTap(Map<String, dynamic> issue) {
    showDialog(
      context: context,
      builder: (context) {
        return IssueDetail(issue: issue);
      },
    );
  }

  Widget buildStatusBadge(String status) {
    Color textColor;
    IconData icon;

    switch (status) {
      case 'active':
        textColor = Colors.orange;
        icon = CupertinoIcons.time;
        break;
      case 'pending':
        textColor = redColor;
        icon = CupertinoIcons.square_list;
        break;
      case 'resolved':
        textColor = primaryColor;
        icon = CupertinoIcons.checkmark_alt_circle;
        break;
      default:
        textColor = Colors.grey;
        icon = CupertinoIcons.question_circle;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: textColor, size: 16),
        const Gap(4),
        Text(
          status.trim(),
          style: TextStyle(color: textColor),
        ),
      ],
    );
  }

  Widget buildCheckBox(bool isSelected) {
    return Checkbox(
      activeColor: primaryColor,
      side: const BorderSide(color: secondaryColor, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      value: isSelected,
      onChanged: (value) {
        setState(() {
          isSelected = value!;
        });
      },
    );
  }

  Widget tableCell(String value, bool isHeader) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        value,
        style: TextStyle(
          fontSize: isHeader ? 14 : 12,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: isHeader ? secondaryColor : textColor1,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildResponsiveSmallView() {
    return ListView.builder(
      itemCount: issues.length,
      itemBuilder: (context, index) {
        return IssuesCard(
          issue: issues[index],
        );
      },
    );
  }
}
