import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_linear_progress_indicator.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/role-admin/features/parking_management/views/parking_main.dart';

class TicketsPage extends StatefulWidget {
  final List<Map<String, dynamic>> tickets;
  final int totalPages;
  const TicketsPage(
      {super.key, required this.tickets, required this.totalPages});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  int _currentPage = 1;

  void _nextPage() {
    if (_currentPage < widget.totalPages) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _prevPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
    }
  }

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
              Expanded(
                child: buildTableView(),
              ),
              buildFooter(),
            ],
          )),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [backBtn()],
      ),
    );
  }

  Widget buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          buildPageSelector(),
          const Spacer(),
          pageContentCount(),
        ],
      ),
    );
  }

  Widget pageContentCount() {
    return Text(
      '$_currentPage-${widget.totalPages}',
      style: const TextStyle(color: secondaryColor),
    );
  }

  Widget buildPageSelector() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          prevBtn(),
          const Gap(8),
          ...generatePageButtons(),
          const Gap(8),
          nextBtn(),
        ],
      ),
    );
  }

  List<Widget> generatePageButtons() {
    List<Widget> pageButtons = [];

    if (widget.totalPages <= 6) {
      // Show all pages if there are 6 or fewer
      for (int i = 1; i <= widget.totalPages; i++) {
        pageButtons.add(pageButton(i));
      }
    } else {
      int startPage = _currentPage > 3 ? _currentPage - 2 : 1;
      int endPage = _currentPage < widget.totalPages - 2
          ? _currentPage + 2
          : widget.totalPages;

      // Show pages around the current page
      for (int i = startPage; i <= endPage; i++) {
        pageButtons.add(pageButton(i));
      }

      // Show dots if there are pages not displayed at the start
      if (startPage > 1) {
        pageButtons.insert(
            0,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text("...", style: TextStyle(color: textColor1)),
            ));
        pageButtons.insert(0, pageButton(1));
      }

      // Show dots if there are pages not displayed at the end
      if (endPage < widget.totalPages) {
        pageButtons.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text("...", style: TextStyle(color: textColor1)),
        ));
        pageButtons.add(pageButton(widget.totalPages));
      }
    }

    return pageButtons;
  }

  Widget pageButton(int pageNumber) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPage = pageNumber;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          pageNumber.toString(),
          style: TextStyle(
            color: _currentPage == pageNumber ? primaryColor : textColor1,
            fontWeight: _currentPage == pageNumber
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget nextBtn() {
    return GestureDetector(
      onTap: _nextPage,
      child: Row(
        children: [
          const VerticalDivider(
            thickness: 1,
            color: textColor1,
          ),
          Text(
            "Next",
            style: TextStyle(
              color:
                  _currentPage < widget.totalPages ? textColor1 : Colors.grey,
              fontSize: 14,
            ),
          ),
          const Gap(8),
          Icon(
            CupertinoIcons.arrow_right_circle,
            color: _currentPage < widget.totalPages ? textColor1 : Colors.grey,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget prevBtn() {
    return GestureDetector(
      onTap: _prevPage,
      child: Row(
        children: [
          Icon(
            CupertinoIcons.arrow_left_circle,
            color: _currentPage > 1 ? textColor1 : Colors.grey,
            size: 14,
          ),
          const Gap(8),
          Text(
            "Previous",
            style: TextStyle(
              color: _currentPage > 1 ? textColor1 : Colors.grey,
              fontSize: 14,
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            color: textColor1,
          ),
        ],
      ),
    );
  }

  Widget backBtn() {
    return IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          CupertinoIcons.arrow_left_circle,
          // size: 12,
          color: textColor1,
        ));
  }

  Widget buildTableView() {
    return Table(
      border: null,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(2),
        5: FlexColumnWidth(2),
        6: FlexColumnWidth(2),
        7: FlexColumnWidth(2),
      },
      children: [
        buildTableHeader(),
        for (var ticket in tickets) buildTableRow(ticket),
      ],
    );
  }

  TableRow buildTableHeader() {
    return TableRow(
      children: [
        buildCheckBox(false),
        tableCell('Vehicle', true),
        tableCell('Time in', true),
        tableCell('Time out', true),
        tableCell('Date', true),
        tableCell('Duration', true),
        tableCell('Amount', true),
        tableCell('Status', true),
      ],
    );
  }

  TableRow buildTableRow(Map<String, dynamic> ticket) {
    return TableRow(
      children: [
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: buildCheckBox(false),
        ),
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: tableCell(ticket['vehicle'], false),
        ),
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: tableCell(timeFormatted(ticket['issued_at']), false),
        ),
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: tableCell(timeFormatted(ticket['expiry_at']), false),
        ),
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: tableCell(dateFormatted(ticket['issued_at']), false),
        ),
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: buildTimeProgressIndicator(
              ticket['issued_at'], ticket['expiry_at']),
        ),
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: tableCell(ticket['amount'].toString(), false),
        ),
        GestureDetector(
          onTap: () => onRowTap(ticket),
          child: buildStatusBadge(ticket['status'].toLowerCase()),
        ),
      ],
    );
  }

  Widget buildTimeProgressIndicator(DateTime startTime, DateTime endTime) {
    return CustomLinearProgressIndicator(
      startTime: startTime,
      endTime: endTime,
    );
  }

  void onRowTap(Map<String, dynamic> ticket) {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return IssueDetail(issue: issue);
    //   },
    // );
  }

  Widget buildStatusBadge(String status) {
    return Center(
      child: Text(
        status.trim(),
        style: getStyle(status),
      ),
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
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: isHeader ? 14 : 12,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader ? secondaryColor : textColor1,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
