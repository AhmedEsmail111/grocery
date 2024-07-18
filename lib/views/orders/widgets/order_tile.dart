import 'package:flutter/material.dart';
import 'package:grocery/core/models/order_model.dart';
import 'package:grocery/core/widgets/fancy_image.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final width = MediaQuery.sizeOf(context).width;
    final color = isDark ? Colors.white : Colors.black;
    final order = Provider.of<OrderModel>(context);

    return ListTile(
      leading: FancyImage(
        imageUrl: order.products.first.imageUrl,
        imageWidth: width * 0.2,
      ),
      title: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(
            order.products.length > 3 ? 3 : order.products.length, (index) {
          if (index == 2) {
            return Text(
              '${order.products[index].title}x${order.quantities[index]}......',
              style: const TextStyle().copyWith(
                fontSize: 18,
                color: color,
              ),
            );
          }
          return Text(
            '${order.products[index].title} x${order.quantities[index]}',
            style: const TextStyle().copyWith(
              fontSize: 18,
              color: color,
            ),
          );
        }),
      ),
      subtitle: Text(
        'Paid: \$${order.totalPrice}',
        style: const TextStyle().copyWith(
          fontSize: 15,
          color: isDark ? Colors.white60 : Colors.black54,
        ),
      ),
      trailing: Text(
        '${order.orderDate.toDate().day}/${order.orderDate.toDate().month}/${order.orderDate.toDate().year}',
        style: const TextStyle().copyWith(
          fontSize: 18,
          color: color,
        ),
      ),
    );
  }
}
