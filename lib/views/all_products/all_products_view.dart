import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/widgets/back_button.dart';
import 'package:grocery/core/widgets/search_text_field.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/views/all_products/all_products_grid_view.dart';
import 'package:provider/provider.dart';

import '../../providers/products_provider.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    final productsProvider = Provider.of<ProductsProvider>(context);
    return PopScope(
      onPopInvoked: (_) {
        productsProvider.setUpValues();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: const Text(
            'All Products',
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                IconlyLight.bag2,
                size: 22,
                color: color,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {},
                child: Icon(
                  IconlyLight.heart,
                  size: 22,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchTextField(),
                SizedBox(
                  height: 16,
                ),
                AllProductsGridView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
