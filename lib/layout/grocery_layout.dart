import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '/providers/bottom_nav_provider.dart';
import '/views/categories/categories_view.dart';
import '../views/cart/cart_view.dart';
import '../views/home/home_view.dart';
import '../views/settings/settings_view.dart';

class GroceryLayout extends StatelessWidget {
  const GroceryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<BottomNavProvider>(context);
    final cartItems = Provider.of<CartProvider>(context).cartItems;
    final views = [
      const HomeView(),
      const CategoriesView(),
      const CartView(),
      const SettingsView(),
    ];
    return Scaffold(
      body: views[navProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) {
          navProvider.changeNavBarScreen(index);
        },
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              navProvider.currentIndex == 0
                  ? IconlyBold.home
                  : IconlyLight.home,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              navProvider.currentIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: badges.Badge(
              badgeAnimation: const badges.BadgeAnimation.size(),
              position: badges.BadgePosition.topEnd(top: -12, end: -7),
              badgeContent: Text(
                cartItems.keys.length.toString(),
                style: const TextStyle().copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              badgeStyle: badges.BadgeStyle(
                badgeColor: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                navProvider.currentIndex == 2
                    ? IconlyBold.buy
                    : IconlyLight.buy,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              navProvider.currentIndex == 3
                  ? IconlyBold.user2
                  : IconlyLight.user2,
            ),
          ),
        ],
      ),
    );
  }
}
