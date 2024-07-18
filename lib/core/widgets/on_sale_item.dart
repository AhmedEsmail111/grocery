import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/product.dart';
import 'package:grocery/core/models/wishlist_model.dart';
import 'package:grocery/core/widgets/fancy_image.dart';
import 'package:grocery/core/widgets/favorite_button.dart';
import 'package:grocery/core/widgets/price_widget.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/viewed_provider.dart';
import '../../views/details/product_details_view.dart';
import 'add_to_cart_icon.dart';

class OnSaleItem extends StatelessWidget {
  const OnSaleItem({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().isDark;
    final width = MediaQuery.sizeOf(context).width;
    final color = isDark ? Colors.white : Colors.black;

    final saleProduct = context.read<Product>();
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor.withOpacity(0.9),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          viewedProvider.addToViewed(productId: saleProduct.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: saleProduct,
                child: const ProductDetailsView(),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FancyImage(
                    imageUrl: saleProduct.imageUrl,
                    imageHeight: width * 0.18,
                    imageWidth: width * 0.18,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Column(
                    children: [
                      FittedBox(
                        child: Text(
                          saleProduct.isPiece ? '1 Piece' : '1 KG',
                          style: const TextStyle().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          AddToCartIcon(
                            productId: saleProduct.id,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          FavoriteButton(
                            wishlistModel: WishlistModel(
                              id: Timestamp.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                              productId: saleProduct.id,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const PriceWidget(),
              const SizedBox(
                height: 4,
              ),
              Text(
                saleProduct.title,
                style: const TextStyle().copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
