import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/viewed_model.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/models/cart_model.dart';
import '../../../core/widgets/error_dialogue.dart';
import '../../../core/widgets/fancy_image.dart';

class ViewedItemTile extends StatelessWidget {
  const ViewedItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedItem = Provider.of<ViewedModel>(context);
    final product = Provider.of<ProductsProvider>(context)
        .productById(viewedItem.productId);
    final user = FirebaseAuth.instance.currentUser;

    final userPrice = product.isOnSale ? product.salePrice : product.price;
    return Material(
      color: Theme.of(context).cardColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        leading: FancyImage(
          imageUrl: product.imageUrl,
        ),
        title: Text(
          product.title,
          style: const TextStyle().copyWith(
            fontSize: 22,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '\$$userPrice',
          style: const TextStyle().copyWith(
            fontSize: 16,
            color: color,
          ),
        ),
        trailing: InkWell(
          borderRadius: BorderRadius.circular(12),
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
            if (!cartProvider.isInCart(product.id)) {
              final cartModel = CartModel(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                productId: product.id,
                quantity: 1,
              );
              cartProvider.addToCart(
                cartModel: cartModel,
                context: context,
              );
            }
          },
          child: Material(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                cartProvider.isInCart(product.id) ? Icons.done : Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
