import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/main_nav/main_header.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MainNavigationClient extends StatelessWidget {
  final Widget child;

  const MainNavigationClient({super.key, required this.child});

  static const double minConstraint = 600;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          Tooltip(
            message: "Profile",
            child: IconButton(
              icon: const Icon(
                CupertinoIcons.person,
                color: textColor2,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Tooltip(
            message: 'Notifications',
            child: Stack(children: [
              IconButton(
                  onPressed: () => context.go('/notifications'),
                  icon: const Icon(CupertinoIcons.bell, color: textColor2)),
              Positioned(
                top: 6,
                right: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: _buildDrawer(context, isMobile: true),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: child,
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
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, {bool isMobile = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = isMobile ? screenWidth * 0.3 : screenWidth * 0.2;

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
          Expanded(child: _buildTabsList(context)),
          if (!isMobile) ...[
            const CustomDivider(),
            _buildProfile(context),
          ],
        ],
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

  Widget _buildTabsList(BuildContext context) {
    final tabs = [
      {'title': 'Dashboard', 'route': 'dashboard'},
      {'title': 'Announcements', 'route': 'announcements'},
      {'title': 'Issues', 'route': 'issues'},
      {'title': 'Water Management', 'route': 'water'},
      {'title': 'Licenses', 'route': 'licenses'},
      {'title': 'Assets', 'route': 'assets'},
      {'title': 'Parking', 'route': 'parking'},
      {'title': 'Alida AI', 'route': 'alida-ai'},
      {'title': 'Settings', 'route': 'settings'},
    ];

    return ListView.builder(
      itemCount: tabs.length,
      itemBuilder: (context, index) {
        final tab = tabs[index];
        return ListTile(
          title: Text(
            tab['title']!,
            style: const TextStyle(color: textColor1),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            context.go("/client/${tab['route']}");
            if (MediaQuery.of(context).size.width < minConstraint) {
              Navigator.of(context).pop();
            }
          },
        );
      },
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
          onPressed: () {}, // TODO: Implement logout functionality
          child: const Text(
            'Logout',
            style: TextStyle(color: textColor1),
          ),
        ),
      ),
    );
  }
}
