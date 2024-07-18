import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/empty_products.dart';
import '../../core/widgets/product_item.dart';
import '../../providers/products_provider.dart';

class AllProductsGridView extends StatefulWidget {
  const AllProductsGridView({super.key});

  @override
  State<AllProductsGridView> createState() => _AllProductsGridViewState();
}

class _AllProductsGridViewState extends State<AllProductsGridView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final allProducts = productsProvider.productsList;
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
                : allProducts.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: height / (height * 1.18),
            ),
            itemBuilder: ((context, index) => Builder(builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: productsProvider.searchControllertext.isNotEmpty
                        ? searchedProducts[index]
                        : allProducts[index],
                    child: const ProductCardItem(),
                  );
                })),
          );
  }
}
