import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_divider.dart';
// import 'package:flutter/widgets.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/main_nav/main_header.dart';
import 'package:portal/features/alida_ai/alida_ai_main.dart';
import 'package:portal/features/announcements/views/announcements_main.dart';
import 'package:portal/features/business_management/businesses_main.dart';
import 'package:portal/features/dashboard/dashboard_main.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:portal/features/issues/issues_main.dart';
import 'package:portal/features/parking_management/parking_main.dart';
import 'package:portal/features/properties_management/properties_main.dart';
import 'package:portal/features/settings/settings_main.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/water_management/water_main.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          buildDrawer(),
          Expanded(
              child: Column(
            children: [
              const MainHeader(currentCity: 'Mutare'),
              Expanded(child: widgetDisplay()), // Use widgetDisplay here
            ],
          )),
        ],
      ),
    );
  }

  final Map<int, Widget> getPages = {
    0: const DashboardMain(),
    1: const AnnouncementsMain(),
    2: const IssuesMain(),
    3: const WaterMain(),
    4: const BusinessesMain(),
    5: const ParkingMain(),
    6: const PropertiesMain(),
    7: const AlidaAiMain(),
    8: const SettingsMain(),
  };

  Widget buildDrawer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: const BoxDecoration(
        color: background2,
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          buildLogo(),
          const CustomDivider(),
          Expanded(
            child: ListView(
              children: [
                buildListTile('Dashboard', 'Dashboard.svg', 0),
                buildListTile('Announcements', null, 1),
                buildListTile('Issues', null, 2),
                buildListTile('Water Management', null, 3),
                buildListTile('Businesses', null, 4),
                buildListTile('Parking', null, 5),
                buildListTile('Properties', null, 6),
                buildListTile('Alida AI', null, 7),
                buildListTile('Settings', 'settings.svg', 8),
              ],
            ),
          ),
          const CustomDivider(),
          profile(),
        ],
      ),
    );
  }

  Widget profile() {
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
            onPressed: () {},
            child: const Text(
              'Logout',
              style: TextStyle(color: textColor1),
            )),
      ),
    );
  }

  Widget buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            // padding: const EdgeInsets.all(8),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
                child: Icon(
              AntDesign.dashboard,
            )),
          ),
          const Gap(8),
          const Text(
            'City council portal',
            style: TextStyle(color: textColor1),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget buildListTile(String title, String? iconPath, int index) {
    bool isSelected = _selectedIndex == index;

    return ListTile(
      leading: Tooltip(
        message: title, // Show title as tooltip when text is hidden
        child: iconPath != null
            ? SvgPicture.asset(
                'lib/assets/icons/$iconPath',
                color: isSelected ? primaryColor : textColor1,
              )
            : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? primaryColor : textColor1,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        _onItemTapped(index);
      },
    );
  }

  void _onItemTapped(int index) {
    saveSP('dashboard', '$index');
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget widgetDisplay() {
    return getPages[_selectedIndex] ?? const DashboardMain();
  }

  Future<void> _checkIndex() async {
    var index = int.parse(
        await getSP('dashboard') == '' ? '0' : await getSP('dashboard'));
    setState(() {
      _selectedIndex = index;
    });
  }
}
