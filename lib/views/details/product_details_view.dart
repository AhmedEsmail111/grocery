import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/product.dart';
import 'package:grocery/core/widgets/back_button.dart';
import 'package:grocery/providers/product_quantity_provider.dart';
import 'package:grocery/views/details/widgets/details_card.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final isDark = context.read<ThemeProvider>().isDark;
    final height = MediaQuery.sizeOf(context).height;

    final product = Provider.of<Product>(context);
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            FancyShimmerImage(
              imageUrl: product.imageUrl,
              height: height * 0.5,
              width: double.infinity,
              boxFit: BoxFit.cover,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: CustomBackButton(),
            ),
          ],
        ),
        ChangeNotifierProvider(
          create: (_) => ProductQuantityProvider(),
          child: const DetailsCard(),
        ),
      ],
    ));
  }
}
