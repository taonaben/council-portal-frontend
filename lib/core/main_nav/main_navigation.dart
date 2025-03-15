import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_divider.dart';
// import 'package:flutter/widgets.dart';
import 'package:portal/constants/colors/colors.dart';
import 'package:portal/core/main_nav/main_header.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MainNavigation extends StatefulWidget {
  final Widget child;
  const MainNavigation({super.key, required this.child});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          buildDrawer(context),
          Expanded(
            child: Column(
              children: [
                const MainHeader(currentCity: 'Mutare'),
                Expanded(child: widget.child), // Display the routed widget here
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: const BoxDecoration(color: background2),
      child: Column(
        children: [
          buildLogo(),
          const CustomDivider(),
          Expanded(
            child: ListView(
              children: [
                buildListTile(context, 'Dashboard', '/dashboard'),
                buildListTile(context, 'Announcements', '/announcements'),
                buildListTile(context, 'Issues', '/issues'),
                buildListTile(context, 'Water Management', '/water'),
                buildListTile(context, 'Licenses', '/licenses'),
                buildListTile(context, 'Businesses', '/businesses'),
                buildListTile(context, 'Parking', '/parking'),
                buildListTile(context, 'Properties', '/properties'),
                buildListTile(context, 'Alida AI', '/alida-ai'),
                buildListTile(context, 'Settings', '/settings'),
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

  Widget buildListTile(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(color: textColor1),
          overflow: TextOverflow.ellipsis),
      onTap: () => context.go(route), // Navigate using GoRouter
    );
  }
}
