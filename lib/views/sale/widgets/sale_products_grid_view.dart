import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/on_sale_item.dart';
import 'package:provider/provider.dart';

import '../../../providers/products_provider.dart';

class SaleProductsGridView extends StatelessWidget {
  const SaleProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final saleProducts =
        Provider.of<ProductsProvider>(context).getOnSaleProducts;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: GridView.builder(
        itemCount: saleProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: height / (height * 1),
        ),
        itemBuilder: ((context, index) => ChangeNotifierProvider.value(
              value: saleProducts[index],
              child: const OnSaleItem(),
            )),
      ),
    );
  }
}
