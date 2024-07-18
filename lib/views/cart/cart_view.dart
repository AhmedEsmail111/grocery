import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/widgets/empty_screen.dart';
import 'package:grocery/core/widgets/loading_manager.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/orders_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/views/cart/widgets/cart_items_list_view.dart';
import 'package:grocery/views/cart/widgets/order_now_row.dart';
import 'package:provider/provider.dart';

import '../../core/utils/functions.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems.values.toList();
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return cartItems.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/cart.png',
            content: 'Your cart is empty\n Add something and make me happy:)',
            buttonText: 'Shop now',
          )
        : CustomLoadingManager(
            isLoading: ordersProvider.isLoading || cartProvider.isLoading,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('Cart(${cartItems.length})'),
                actions: [
                  IconButton(
                    onPressed: () {
                      showAlertDialogue(
                        context: context,
                        title: 'Clear Cart',
                        content: 'Your Cart will be cleared!',
                        onPressed: () {
                          cartProvider.clearCart(context: context);
                        },
                      );
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  )
                ],
              ),
              body: const SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: OrderNowRow(),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CartItemsListView(),
                  ],
                ),
              ),
            ),
          );
  }
}
