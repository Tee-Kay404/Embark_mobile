import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final Function(int) onPageChanged;
  final int currentPage;
  const BottomNavbar(
      {super.key, required this.onPageChanged, required this.currentPage});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600.withValues(alpha: 0.5),
                  spreadRadius: 2.0,
                  blurRadius: 5.0),
            ]),
        child: BottomNavigationBar(
            currentIndex: widget.currentPage,
            onTap: widget.onPageChanged,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
                fontSize: 15, color: Theme.of(context).colorScheme.primary),
            elevation: 28,
            unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.black),
            iconSize: 23,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2_outlined), label: 'Items'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_outlined), label: 'Orders'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: 'Settings'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined), label: 'Account'),
            ]),
      ),
    );
  }
}
