import 'package:Embark_mobile/components/drawer/drawer.dart';
import 'package:Embark_mobile/feature/models/cart_page.dart';
import 'package:Embark_mobile/feature/shared/bottom_navbar.dart';
import 'package:Embark_mobile/pages/account.dart';
import 'package:Embark_mobile/pages/orders.dart';
import 'package:Embark_mobile/routes.dart';
import 'package:flutter/material.dart';
import 'package:Embark_mobile/feature/auth/settings.dart';
import 'package:Embark_mobile/pages/items.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ValueNotifier<bool> _triggerSearchNotifier = ValueNotifier(false);

  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _triggerSearchNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> get pages => [
        ItemsPage(triggerSearchNotifier: _triggerSearchNotifier),
        OrdersPage(products: {}),
        CartPage(products: {}),
        SettingsPage(),
        AccountPage(),
      ];

  void _triggerSearchFromFab() {
    _pageController.jumpToPage(0);
    Future.delayed(Duration(milliseconds: 100), () {
      _triggerSearchNotifier.value = true;
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _onNavTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _color = Theme.of(context).colorScheme.primary;
    final style = Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: 16,
        color: Theme.of(context).colorScheme.surface,
        fontWeight: FontWeight.w600);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.3,
        spacing: 10,
        spaceBetweenChildren: 1,
        children: [
          SpeedDialChild(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.surface,
            child: Icon(Icons.category_outlined),
            label: 'Categories',
            labelStyle: style,
            labelBackgroundColor: _color,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                PageRoutes.category.name,
              );
            },
          ),
          SpeedDialChild(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.surface,
            child: Icon(Icons.support_agent),
            label: 'Support',
            labelStyle: style,
            labelBackgroundColor: _color,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, PageRoutes.contact.name);
            },
          ),
          SpeedDialChild(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              child: Icon(Icons.search),
              label: 'Search',
              labelStyle: style,
              labelBackgroundColor: _color,
              onTap: _triggerSearchFromFab),
        ],
      ),
      drawer: DrawerPage(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: BottomNavbar(
        currentPage: _currentPage,
        onPageChanged: _onNavTapped,
      ),
    );
  }
}
