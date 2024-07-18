import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/empty_products.dart';
import '../../../core/widgets/product_item.dart';
import '../../../providers/products_provider.dart';

class CategoryProductsGridView extends StatelessWidget {
  const CategoryProductsGridView({super.key, required this.catName});
  final String catName;
  @override
  Widget build(BuildContext context) {
    // final isDark = Provider.of<ThemeProvider>(context).isDark;
    final height = MediaQuery.sizeOf(context).height;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final categoryProducts = productsProvider.categoryProducts(catName);
    final searchedProducts = productsProvider.searchedProducts;
    return productsProvider.searchControllertext.isNotEmpty &&
            searchedProducts.isEmpty
        ? const EmptyProducts(
            text: 'No Products found! \n try another keyword',
          )
        : GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: productsProvider.searchControllertext.isNotEmpty
                ? searchedProducts.length
                : categoryProducts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: height / (height * 1.18),
            ),
            itemBuilder: ((context, index) => ChangeNotifierProvider.value(
                  value: productsProvider.searchControllertext.isNotEmpty
                      ? searchedProducts[index]
                      : categoryProducts[index],
                  child: const ProductCardItem(),
                )),
          );
  }
}
