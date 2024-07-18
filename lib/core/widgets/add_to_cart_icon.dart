import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/models/cart_model.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/theme_provider.dart';
import 'error_dialogue.dart';

class AddToCartIcon extends StatelessWidget {
  const AddToCartIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;

    final user = FirebaseAuth.instance.currentUser;
    return GestureDetector(
      onTap: () {
        if (user == null) {
          showDialog(
            context: context,
            builder: (_) => const CustomErrorDialogue(
              contentText: 'No user found! please log in first.',
            ),
          );
          return;
        }
        if (!cartProvider.isInCart(productId)) {
          final cartModel = CartModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            productId: productId,
            quantity: 1,
          );
          cartProvider.addToCart(
            cartModel: cartModel,
            context: context,
          );
        }
      },
      child: Icon(
        cartProvider.isInCart(productId) ? IconlyBold.bag : IconlyLight.bag2,
        size: 22,
        color: cartProvider.isInCart(productId) ? Colors.green : color,
      ),
    );
  }
}
