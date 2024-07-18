import 'package:flutter/material.dart';
import 'package:grocery/core/models/product.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().isDark;
    final color = isDark ? Colors.white54 : Colors.black54;
    final product = context.read<Product>();
    return RichText(
      text: TextSpan(
        text: '\$${product.salePrice}  ',
        style: const TextStyle().copyWith(
          color: Colors.teal,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: "\$${product.price}",
            style: const TextStyle().copyWith(
              decoration: TextDecoration.lineThrough,
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
