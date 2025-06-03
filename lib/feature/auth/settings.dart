import 'package:Embark_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Map<String, dynamic>> preferences = [
    {
      'title': 'Account',
      'icons': Icons.people_outline,
    },
    {
      'title': 'Payment method',
      'icons': Icons.security_outlined,
    },
    {
      'title': 'Face ID & PIN ',
      'icons': Icons.lock_outline,
    },
    {
      'title': 'App Theme',
      'icons': Icons.color_lens_outlined,
      'route': PageRoutes.themeToggle.name
    },
    {
      'title': 'Privacy',
      'icons': Icons.privacy_tip_outlined,
    },
    {
      'title': 'Notifications',
      'icons': Icons.notifications_none,
    },
    {
      'title': 'Get Help',
      'icons': Icons.help_outline_outlined,
    },
    {
      'title': 'Socials',
      'icons': Icons.people_alt_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, PageRoutes.dashBoard.name),
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 22,
            color: Colors.white,
          ),
          title: Text('Settings'),
          titleTextStyle: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Gap(10.h),
            Expanded(
              child: ListView(
                  children: preferences.map((item) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: ListTile(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: theme.colorScheme.primary,
                        contentPadding: EdgeInsets.all(8),
                        minTileHeight: 20,
                        leading: Icon(
                          item['icons'] as IconData,
                          size: 18,
                          color: theme.colorScheme.surface,
                        ),
                        title: Text(
                          item['title'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.surface),
                        ),
                        onTap: () {
                          final route = item['route'];
                          if (route != null && route is String) {
                            Navigator.pushNamed(context, route);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: theme.colorScheme.primary,
                                title: Text(
                                  "Oops!",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.surface,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                content: Text(
                                  "Something went wrong. This feature isn't available yet.",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.surface,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                        splashFactory: NoSplash.splashFactory,
                                        backgroundColor: WidgetStatePropertyAll(
                                            theme.colorScheme.surface)),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "OK",
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                              color: theme.colorScheme.primary,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              }).toList()),
            ),
          ],
        ));
  }
}
