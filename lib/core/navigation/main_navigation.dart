import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/core/navigation/main_header.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:portal/features/alida_ai/alida_ai_main.dart';
import 'package:portal/features/notifications/notifications_main.dart';
import 'package:portal/features/parking/main/parking_main.dart';
import 'package:portal/features/profile/profile_main.dart';
import 'package:portal/features/settings/settings.dart';
import 'package:portal/features/water/views/water_main.dart';

class MainNavigation extends StatefulWidget {
  final int currentIndex;
  const MainNavigation({super.key, this.currentIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  static const double minConstraint = 600;

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  final List<Widget> _screens = const [
    WaterMain(),
    ParkingMainClient(),
    AlidaAiMain(),
    NotificationsMain(),
    SettingsMain(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return constraints.maxWidth < minConstraint
            ? _buildMobileView(context)
            : _buildDesktopView(context);
      },
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.water_drop_outlined), label: 'Water'),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_parking_outlined), label: 'Parking'),
            BottomNavigationBarItem(
                icon: Icon(Icons.smart_toy_outlined), label: 'Alida AI'),
            BottomNavigationBarItem(
                icon: Icon(Icons.inbox_outlined), label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildDrawer(context),
          Expanded(
            child: Column(
              children: [
                const MainHeader(currentCity: 'client'),
                Expanded(child: _screens[_currentIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.2;

    return Container(
      width: drawerWidth,
      decoration: BoxDecoration(
        color: background2,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          _buildLogo(),
          const CustomDivider(),
          _buildDrawerItems(),
          const CustomDivider(),
          _buildProfile(context),
        ],
      ),
    );
  }

  Widget _buildDrawerItems() {
    final List<Map<String, dynamic>> tabs = [
      {'title': 'Water Management', 'index': 0},
      {'title': 'Parking', 'index': 1},
      {'title': 'Alida AI', 'index': 2},
      {'title': 'Settings', 'index': 3},
    ];

    return Expanded(
      child: ListView.builder(
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          return ListTile(
            title: Text(
              tab['title']!,
              style: const TextStyle(color: textColor1),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => setState(() => _currentIndex = tab['index']),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(AntDesign.dashboard),
            ),
          ),
          const Gap(8),
          const Expanded(
            child: Text(
              'City council portal',
              style: TextStyle(color: textColor1),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        leading: GestureDetector(
          onTap: () => context.go('/profile'),
          child: const CircleAvatar(
            backgroundColor: primaryColor,
            child: Icon(
              CupertinoIcons.profile_circled,
              color: textColor1,
            ),
          ),
        ),
        trailing: TextButton(
          onPressed: () {
            // TODO: Implement logout functionality
          },
          child: const Text(
            'Logout',
            style: TextStyle(color: textColor1),
          ),
        ),
      ),
    );
  }
}
