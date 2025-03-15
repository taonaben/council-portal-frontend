import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/utils/string_methods.dart';
import 'package:portal/features/parking_management/components/daily_revenue_box.dart';
import 'package:portal/features/parking_management/components/ticket_tile.dart';

List<Map<String, dynamic>> tickets = [
  {
    'id': '1',
    'vehicle': 'AEF 4567',
    'issued_time': "30min",
    'issued_at': DateTime.now(),
    'expiry_at': DateTime.now().add(
      const Duration(minutes: 30),
    ),
    'amount': 1,
    'status': 'active',
  },
  {
    'id': '2',
    'vehicle': 'AEF 4067',
    'issued_time': "1hr",
    'issued_at': DateTime.now(),
    'expiry_at': DateTime.now().add(
      const Duration(minutes: 60),
    ),
    'amount': 1,
    'status': 'used',
  },
  {
    'id': '3',
    'vehicle': 'AEF 4867',
    'issued_time': "30min",
    'issued_at': DateTime.now(),
    'expiry_at': DateTime.now().add(
      const Duration(minutes: 30),
    ),
    'amount': 1,
    'status': 'inactive',
  },
  {
    'id': '4',
    'vehicle': 'AEF 4967',
    'issued_time': "2hr",
    'issued_at': DateTime.now(),
    'expiry_at': DateTime.now().add(
      const Duration(minutes: 120),
    ),
    'amount': 2,
    'status': 'active',
  },
  {
    'id': '5',
    'vehicle': 'AEF 5067',
    'issued_time': "45min",
    'issued_at': DateTime.now(),
    'expiry_at': DateTime.now().add(
      const Duration(minutes: 45),
    ),
    'amount': 1,
    'status': 'used',
  },
  {
    'id': '6',
    'vehicle': 'AEF 5167',
    'issued_time': "1hr 30min",
    'issued_at': DateTime.now(),
    'expiry_at': DateTime.now().add(
      const Duration(minutes: 90),
    ),
    'amount': 1,
    'status': 'inactive',
  }
];

class ParkingMain extends StatelessWidget {
  const ParkingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 5;

          if (constraints.maxWidth < 600) {
            crossAxisCount = 2; // Mobile
          } else if (constraints.maxWidth < 1000) {
            crossAxisCount = 3; // Tablet
          } else {
            crossAxisCount = 5; // Desktop
          }

          return Center(
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: crossAxisCount >= 4 ? 3 : 2,
                    mainAxisCellCount: 2,
                    child: Center(child: ticketsSection()),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: crossAxisCount >= 4 ? 2 : 1,
                    mainAxisCellCount: 1,
                    child: Center(child: incomeStatsSection()),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Center(child: dailyRevenueSection()),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: Center(child: ticketsIssuedSection()),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: crossAxisCount >= 4 ? 2 : 1,
                    mainAxisCellCount: 1,
                    child: Center(child: arrearsSection()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildBox(String label, Widget child) {
  return Card(
    color: background2,
    shadowColor: primaryColor,
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(capitalize(label),
              style: const TextStyle(
                  color: textColor1, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Expanded(child: child),
        ],
      ),
    ),
  );
}

Widget ticketsSection() {
  return buildBox(
    'Tickets',
    ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return TicketTile(ticket: ticket);
        }),
  );
}

Widget incomeStatsSection() {
  return buildBox('daily income', const Center(child: Text('Daily Income')));
}

Widget dailyRevenueSection() {
  return buildBox(
    'today revenue',
    const DailyRevenueBox(revenue: 100000.0),
  );
}

Widget ticketsIssuedSection() {
  return buildBox(
    'ticket issued',
    const Center(
      child: Text('Ticket Issued'),
    ),
  );
}

Widget arrearsSection() {
  return buildBox(
    'arrears',
    const Center(
      child: Text('Arrears'),
    ),
  );
}
