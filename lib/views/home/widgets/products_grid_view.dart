import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/product_item.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final allProducts = Provider.of<ProductsProvider>(context).productsList;
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: allProducts.length < 4 ? allProducts.length : 4,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: height / (height * 1.20),
      ),
      itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            value: allProducts[index],
            child: const ProductCardItem(),
          )),
    );
  }
}
