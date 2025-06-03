import 'package:Embark_mobile/components/drawer/drawer.dart';
import 'package:Embark_mobile/feature/models/cart_page.dart';
import 'package:Embark_mobile/feature/shared/bottom_navbar.dart';
import 'package:Embark_mobile/pages/account.dart';
import 'package:Embark_mobile/pages/orders.dart';
import 'package:flutter/material.dart';
import 'package:Embark_mobile/feature/auth/settings.dart';
import 'package:Embark_mobile/pages/items.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentPage = 0;

  List<Widget> get pages => [
        ItemsPage(),
        OrdersPage(
          products: {},
        ),
        CartPage(products: {}),
        SettingsPage(),
        AccountPage()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.transparent,
          isExtended: true,
          mini: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          onPressed: () {
            showDialog(
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.primary,
                title: Text('Add product to inventory list?'),
                titleTextStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
                content: TextField(
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      fillColor: Theme.of(context).colorScheme.surface,
                      filled: true,
                      hintText: 'Add product',
                      hintStyle:
                          TextStyle(fontSize: 16, color: Colors.grey.shade500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      )),
                ),
                actions: [
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).colorScheme.surface),
                          foregroundColor: WidgetStatePropertyAll(Colors.blue)),
                      child: Text(
                        'Add',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                          foregroundColor: WidgetStatePropertyAll(Colors.blue)),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              context: context,
            );
          },
          child: Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
        drawer: DrawerPage(),
        body: IndexedStack(
          index: _currentPage,
          children: pages,
        ),
        bottomNavigationBar: BottomNavbar(
          currentPage: _currentPage,
          onPageChanged: (value) => setState(() {
            _currentPage = value;
          }),
        ));
  }
}
