import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';
import '../../views/home/widgets/on_sale_marker.dart';
import 'on_sale_item.dart';

class OnSaleListView extends StatelessWidget {
  const OnSaleListView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final saleProducts = context.read<ProductsProvider>().getOnSaleProducts;
    return Row(
      children: [
        const OnSaleMark(),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: SizedBox(
            height: height * 0.20,
            child: ListView.separated(
              padding: const EdgeInsets.only(right: 12),
              scrollDirection: Axis.horizontal,
              itemCount: saleProducts.length < 10 ? saleProducts.length : 10,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: saleProducts[index],
                  child: const OnSaleItem(),
                );
              },
              separatorBuilder: (ctx, index) => const SizedBox(
                width: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
