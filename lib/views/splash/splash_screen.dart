import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery/core/utils/contants.dart';
import 'package:grocery/layout/grocery_layout.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/orders_provider.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:grocery/providers/profile_provider.dart';
import 'package:grocery/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var images = List<String>.from(authSwiperImages);
  @override
  void initState() {
    super.initState();
    images.shuffle();
    Future.delayed(const Duration(microseconds: 1), () async {
      await context.read<ProfileProvider>().getUserInfo();
      await context.read<ProductsProvider>().fetchProducts(context);
      await context.read<CartProvider>().fetchCart();
      await context.read<WishlistProvider>().fetchWishlist();
      await context.read<OrdersProvider>().fetchOrders();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const GroceryLayout(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            images[0],
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            child: const Center(
              child: SpinKitFadingFour(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
