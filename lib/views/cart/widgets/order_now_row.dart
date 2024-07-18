import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/cart_model.dart';
import 'package:grocery/core/models/order_model.dart';
import 'package:grocery/core/widgets/custom_button.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/orders_provider.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/payment/payment_intent_input_model.dart';
import '../../../core/utils/api_keys.dart';
import '../../../providers/theme_provider.dart';

class OrderNowRow extends StatefulWidget {
  const OrderNowRow({super.key});

  @override
  State<OrderNowRow> createState() => _OrderNowRowState();
}

class _OrderNowRowState extends State<OrderNowRow> {
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final cartItems =
        Provider.of<CartProvider>(context).cartItems.values.toList();
    final productsProvider = Provider.of<ProductsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final List<String> productsIds =
        Provider.of<CartProvider>(context).cartItems.keys.toList();
    final products = productsProvider.loadSpecificProductsByIds(productsIds);

    double totalPrice() {
      double total = 0;
      for (CartModel item in cartItems) {
        final product = productsProvider.productById(item.productId);
        final productPrice =
            product.isOnSale ? product.salePrice : product.price;

        total += productPrice * item.quantity;
      }
      return total;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          onTap: () async {
            final paymentIntentInputModel = PaymentIntentInputModel(
              amount: (totalPrice() + 100).toStringAsFixed(0),
              currency: 'USD',
              customerId: customerId,
            );

            final wasPaymentSuccessful = await ordersProvider.makeStripePayment(
              paymentIntentInputModel: paymentIntentInputModel,
              context: context,
            );
            if (wasPaymentSuccessful) {
              final user = FirebaseAuth.instance.currentUser;
              final uuid = const Uuid().v4();

              final orderModel = OrderModel(
                orderId: uuid,
                products: products,
                totalPrice: totalPrice(),
                orderDate: Timestamp.now(),
                quantities: List<int>.from(
                  cartItems.map((item) => item.quantity),
                ),
                userId: user!.uid,
                userName: user.displayName ?? '',
              );

              if (context.mounted) {
                await ordersProvider.placeOrder(
                  orderModel: orderModel,
                  context: context,
                );
              }
              if (context.mounted) {
                context
                    .read<CartProvider>()
                    .clearCart(context: context, canShowSnackBar: false);
              }
            }
          },
          height: 48,
          background: Colors.green,
          text: 'Order now',
          borderRadius: 10,
        ),
        Text(
          'Total: \$${totalPrice().toStringAsFixed(2)}',
          style: const TextStyle().copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
