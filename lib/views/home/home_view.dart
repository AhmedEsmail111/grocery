import 'package:flutter/material.dart';
import 'package:grocery/core/utils/contants.dart';
import 'package:grocery/views/all_products/all_products_view.dart';
import 'package:grocery/views/sale/sale_view.dart';
import 'package:provider/provider.dart';

import '/providers/theme_provider.dart';
import '../../core/widgets/on_sale_list_view.dart';
import '../../core/widgets/swiper.dart';
import 'widgets/products_grid_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    // final allProducts = Provider.of<ProductsProvider>(context).getProducts;
    // final saleProducts =
    //     Provider.of<ProductsProvider>(context).getOnSaleProducts;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSwiper(
              images: homeSwiperImages,
              isWholePage: false,
              height: height * 0.33,
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SaleView(),
                  ),
                );
              },
              child: Text(
                'View All',
                style: const TextStyle().copyWith(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const OnSaleListView(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Our Products',
                    style: const TextStyle().copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AllProductsView(),
                        ),
                      );
                    },
                    child: Text(
                      'Browse all',
                      style: const TextStyle().copyWith(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: ProductsGridView(),
            ),
          ],
        ),
      ),
    );
  }
}
