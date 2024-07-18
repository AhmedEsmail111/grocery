import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/empty_products.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/back_button.dart';
import 'widgets/sale_products_grid_view.dart';

class SaleView extends StatelessWidget {
  const SaleView({super.key});

  @override
  Widget build(BuildContext context) {
    final saleProducts =
        Provider.of<ProductsProvider>(context).getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Products on sale'),
      ),
      body: saleProducts.isEmpty
          ? const EmptyProducts(
              text: 'No Products on sale at the moment.\n Stay tuned!',
            )
          : const SaleProductsGridView(),
    );
  }
}
