import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/back_button.dart';
import 'package:grocery/core/widgets/empty_screen.dart';
import 'package:grocery/providers/orders_provider.dart';
import 'package:grocery/views/orders/widgets/orders_list_view.dart';
import 'package:provider/provider.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context).orders;
    return orders.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/cart.png',
            content:
                'You didn\'t place any orders yet\nOrder something and make me happy:) ',
            buttonText: 'Shop now',
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: const CustomBackButton(),
              title: Text(
                'Your orders (${orders.length})',
              ),
            ),
            body: const OrdersListView(),
          );
  }
}
