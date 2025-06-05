import 'package:Embark_mobile/feature/providers/cart_provider.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String? userName;
  final user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> drawerItems = [
    {
      "icon": Icons.dashboard_customize_outlined,
      "title": "Dashboard",
      'route': PageRoutes.dashBoard.name
    },
    {
      "icon": Icons.shopping_cart_outlined,
      "title": "Cart",
      'route': PageRoutes.cartPage.name
    },
    {
      "icon": Icons.category_outlined,
      "title": "Category",
      'route': PageRoutes.category.name
    },
    {
      "icon": Icons.discount_outlined,
      "title": "Discount and Offers",
      'route': PageRoutes.discountOffer.name
    },
    {
      "icon": Icons.emoji_emotions_outlined,
      "title": "Gift Cards",
      'route': PageRoutes.giftCards.name
    },
    {
      "icon": Icons.build_outlined,
      "title": "Settings",
      'route': PageRoutes.settings.name
    },
    {
      "icon": Icons.contact_mail_outlined,
      "title": "Contact",
      'route': PageRoutes.contact.name
    },
  ];
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('saved_username') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = Provider.of<CartProvider>(context).cart;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: null,
            ),
            // margin: EdgeInsets.only(bottom: 8),
            padding: EdgeInsets.all(16),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Gap(20.h),
                  Center(
                      child: Text(
                    'EMBARK!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        color: Theme.of(context).colorScheme.surface),
                  )),
                  Gap(25.h),
                  ListTile(
                    minTileHeight: 64,
                    // tileColor: Colors.grey,
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      radius: 28,
                      child: Text(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                        user?.email?.characters.first.toUpperCase() ?? '?',
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        Text(
                          user?.email?.toString() ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),

                    subtitle: Text('customer',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.surface)),
                  ),
                ],
              ),
            ),
          ),
          // Properly map drawer items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 5),
              itemCount: drawerItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  splashColor: Colors.transparent,
                  leading: Icon(
                    drawerItems[index]["icon"],
                    size: 20,
                  ),
                  title: Text(
                    drawerItems[index]["title"],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    if (drawerItems[index]['route'] ==
                        PageRoutes.cartPage.name) {
                      Navigator.pushNamed(
                        context,
                        PageRoutes.cartPage.name,
                        arguments: {
                          'products': cartProducts,
                        },
                      );
                    } else {
                      Navigator.pushNamed(context, drawerItems[index]['route']);
                    }
                  },
                );
              },
            ),
          ),
          ListTile(
            splashColor: Colors.transparent,
            leading: Icon(
              Icons.logout_outlined,
              size: 20,
            ),
            title: Text('Logout',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () =>
                Navigator.pushReplacementNamed(context, PageRoutes.login.name),
          )
        ],
      ),
    );
  }
}
