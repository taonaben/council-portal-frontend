import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:portal/components/widgets/custom_circularProgressIndicator.dart';
import 'package:portal/components/widgets/custom_divider.dart';
import 'package:portal/components/widgets/custom_snackbar.dart';
import 'package:portal/constants/colors.dart';
import 'package:portal/constants/dimensions.dart';
import 'package:portal/core/utils/shared_prefs.dart';
import 'package:portal/features/auth/model/user_model.dart';
import 'package:portal/features/auth/providers/user_provider.dart';
import 'package:portal/features/auth/services/auth_services.dart';
import 'package:portal/features/auth/services/user_services.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsMain extends ConsumerStatefulWidget {
  const SettingsMain({super.key});

  @override
  ConsumerState<SettingsMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends ConsumerState<SettingsMain> {
  late int userId;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _initializeUserId();
  }

  Future<void> _initializeUserId() async {
    String userIdStr = await getSP("user");
    if (mounted) {
      setState(() {
        userId = int.parse(userIdStr);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider(userId));

    return userAsyncValue.when(
      data: (user) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildHeader(user!),
                const Gap(20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        buildBody(user),
                        const Gap(20),
                        buildFooter(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (err, stack) {
        return Center(child: Text('Error: $err'));
      },
      loading: () => const Center(
          child: CustomCircularProgressIndicator(color: textColor2)),
    );
  }

  Widget buildHeader(User user) {
    return Card(
      color: background1,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(uniBorderRadius),
      ),
      child: ListTile(
        leading: const Icon(Icons.person, size: 50),
        title: Text("@${user.username}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${user.first_name} ${user.last_name}",
            ),
            const Gap(5),
            Text(
              user.email,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBody(User user) {
    return Column(
      children: [
        CupertinoListSection.insetGrouped(
          decoration: BoxDecoration(
            color: background2,
            borderRadius: BorderRadius.circular(uniBorderRadius),
          ),
          backgroundColor: background1,
          separatorColor: textColor1,
          children: [
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.person, color: textColor1),
              title: const Text('Profile', style: TextStyle(color: textColor1)),
              trailing: const CupertinoListTileChevron(),
              onTap: () => context.pushNamed("user_profile", extra: user),
            ),
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.person_2, color: textColor1),
              title:
                  const Text('Accounts', style: TextStyle(color: textColor1)),
              trailing: const CupertinoListTileChevron(),
              onTap: () => context.pushNamed("accounts"),
            ),
          ],
        ),
        CupertinoListSection.insetGrouped(
          decoration: BoxDecoration(
            color: background2,
            borderRadius: BorderRadius.circular(uniBorderRadius),
          ),
          backgroundColor: background1,
          separatorColor: textColor2,
          children: [
            CupertinoListTile(
              leading:
                  const Icon(CupertinoIcons.question_circle, color: textColor1),
              title: const Text('Help & Support',
                  style: TextStyle(color: textColor1)),
              trailing: const CupertinoListTileChevron(),
              onTap: () {},
            ),
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.doc_text, color: textColor1),
              title: const Text('Terms & Conditions',
                  style: TextStyle(color: textColor1)),
              trailing: const CupertinoListTileChevron(),
              onTap: () => context.pushNamed("terms-of-service"),
            ),
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.moon, color: textColor1),
              title:
                  const Text('Dark Mode', style: TextStyle(color: textColor1)),
              trailing: CupertinoSwitch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  }),
            ),
             CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.bell,
                color: textColor1,
              ),
              title: const Text('Manage Notification ',
                  style: TextStyle(color: textColor1)),
              trailing: const CupertinoListTileChevron(),
              onTap: () => context.pushNamed('notification-settings'),
            ),

            CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.shield,
                color: textColor1,
              ),
              title: const Text('Privacy Policy',
                  style: TextStyle(color: textColor1)),
              trailing: const CupertinoListTileChevron(),
              onTap: () => context.pushNamed('privacy-policy'),
            ),
          ],
        ),
        CupertinoListSection.insetGrouped(
          decoration: BoxDecoration(
            color: background2,
            borderRadius: BorderRadius.circular(uniBorderRadius),
          ),
          backgroundColor: background1,
          separatorColor: textColor1,
          children: [
            const CupertinoListTile(
              leading: const Icon(
                CupertinoIcons.info,
                color: secondaryColor,
              ),
              title: const Text('App Version',
                  style: TextStyle(color: secondaryColor)),
              trailing:
                  const Text('1.0.0', style: TextStyle(color: secondaryColor)),
            ),
            CupertinoListTile(
              leading:
                  const Icon(CupertinoIcons.square_arrow_left, color: redColor),
              title: const Text('Logout', style: TextStyle(color: redColor)),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () async {
                            final result = await AuthServices().logout();

                            if (result) {
                              await clearSP();
                              context.goNamed("login");
                            } else {
                              const CustomSnackbar(
                                      message:
                                          "Logout failed. Please try again.",
                                      color: redColor)
                                  .showSnackBar(context);
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFooter() {
    return const Text(
      "© 2025 City Council Portal. All rights reserved.",
      style: TextStyle(color: secondaryColor),
    );
  }
}
