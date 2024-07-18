import 'package:flutter/material.dart';
import 'package:grocery/views/cart/widgets/cart_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';

class CartItemsListView extends StatelessWidget {
  const CartItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems.values.toList().reversed.toList();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartItems.length,
      itemBuilder: ((context, index) {
        return ChangeNotifierProvider.value(
          value: cartItems[index],
          child: const CartItem(),
        );
      }),
      separatorBuilder: ((context, index) => const SizedBox(
            height: 8,
          )),
    );
  }
}
