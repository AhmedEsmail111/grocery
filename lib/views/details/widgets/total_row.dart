import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/product.dart';
import 'package:grocery/core/widgets/custom_button.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/product_quantity_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/models/cart_model.dart';
import '../../../core/widgets/error_dialogue.dart';

class TotalRow extends StatelessWidget {
  const TotalRow({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    final product = Provider.of<Product>(context);
    final quantity = Provider.of<ProductQuantityProvider>(context).quantity;
    final cartProvider = Provider.of<CartProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    final userPrice = product.isOnSale ? product.salePrice : product.price;
    final totalPrice = (userPrice * quantity).toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total',
                style: const TextStyle().copyWith(
                  fontSize: 20,
                  color: Colors.red.shade300,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              RichText(
                text: TextSpan(
                  text: '\$ $totalPrice',
                  style: const TextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: color,
                  ),
                  children: [
                    TextSpan(
                      text: product.isPiece ? '/Piece' : '/kg',
                      style: const TextStyle().copyWith(
                        color: color,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomButton(
            borderRadius: 10,
            height: 50,
            background: Colors.green,
            text: cartProvider.isInCart(product.id) ? 'in cart' : 'Add to cart',
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
                  quantity: quantity,
                );
                cartProvider.addToCart(
                  cartModel: cartModel,
                  context: context,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
