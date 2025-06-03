import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<CartProvider>(context).order;
    final user = FirebaseAuth.instance.currentUser;
    final theme = Theme.of(context);

    Widget sectionTitle(String title) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 0.1,
              color: Colors.grey.shade900,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                title,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
          ],
        );

    Widget settingsTile(IconData icon, String label,
        {Color? iconColor, VoidCallback? onTap}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 0.6),
          ),
          leading: Icon(icon, color: iconColor ?? Colors.grey.shade600),
          title: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey.shade600,
          ),
          onTap: onTap,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.surface,
        title: const Text("My Account"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushNamed(context, PageRoutes.dashBoard.name)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
            Padding(
              padding: EdgeInsets.all(10.0).copyWith(top: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: EdgeInsets.all(10),
                tileColor: theme.colorScheme.primary,
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.surface,
                  foregroundColor: theme.colorScheme.primary,
                  radius: 30,
                  child: Icon(Icons.person),
                ),
                title: const Text("Emma Wilson"),
                titleTextStyle: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    color: theme.colorScheme.surface),
                subtitle: Text(user?.email?.toString() ?? ''),
                subtitleTextStyle: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: theme.colorScheme.surface),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, PageRoutes.order.name),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Orders",
                                style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.surface)),
                            Gap(5),
                            Text(
                              order.length.toString(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.surface),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reward Points",
                            style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.surface),
                          ),
                          Gap(5),
                          Text(
                            "230 pts",
                            style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.surface),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            sectionTitle("My Orders"),
            settingsTile(Icons.receipt_long, "Order History",
                onTap: () =>
                    Navigator.pushNamed(context, PageRoutes.order.name)),
            settingsTile(Icons.local_shipping_outlined, "Track Current Order"),
            sectionTitle("Payment & Address"),
            settingsTile(Icons.credit_card, "Payment Methods"),
            settingsTile(Icons.location_on_outlined, "Shipping Addresses"),
            sectionTitle("Settings"),
            settingsTile(Icons.notifications_none, "Notifications"),
            settingsTile(Icons.help_outline, "Help Center"),
            settingsTile(Icons.logout, "Sign Out",
                iconColor: Colors.red,
                onTap: () =>
                    Navigator.pushNamed(context, PageRoutes.login.name)),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
