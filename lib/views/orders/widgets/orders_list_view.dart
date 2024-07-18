import 'package:flutter/material.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/views/orders/widgets/order_tile.dart';
import 'package:provider/provider.dart';

import '../../../providers/orders_provider.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final orders = Provider.of<OrdersProvider>(context).orders;
    return ListView.separated(
      itemBuilder: ((context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
            child: ChangeNotifierProvider.value(
              value: orders[index],
              child: const OrderTile(),
            ),
          )),
      separatorBuilder: (ctx, index) => Divider(
        thickness: 0.5,
        color: isDark ? Colors.white60 : Colors.black87,
      ),
      itemCount: orders.length,
    );
  }
}
