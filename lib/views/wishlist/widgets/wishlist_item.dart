import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/wishlist_model.dart';
import 'package:grocery/core/widgets/add_to_cart_icon.dart';
import 'package:grocery/core/widgets/fancy_image.dart';
import 'package:grocery/providers/products_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/favorite_button.dart';
import '../../../providers/viewed_provider.dart';
import '../../details/product_details_view.dart';

class WishListItem extends StatelessWidget {
  const WishListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final viewedProvider = Provider.of<ViewedProvider>(context);

    final wishItem = Provider.of<WishlistModel>(context);
    final product =
        Provider.of<ProductsProvider>(context).productById(wishItem.productId);

    final userPrice = product.isOnSale ? product.salePrice : product.price;
    final color = isDark ? Colors.white : Colors.black;
    final width = MediaQuery.sizeOf(context).width;
    return Material(
      color: Theme.of(context).cardColor.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          viewedProvider.addToViewed(productId: product.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: product,
                child: const ProductDetailsView(),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: FancyImage(
                  imageUrl: product.imageUrl,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 48,
                          ),
                          AddToCartIcon(
                            productId: wishItem.productId,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          FavoriteButton(
                            wishlistModel: WishlistModel(
                              id: Timestamp.now()
                                  .microsecondsSinceEpoch
                                  .toString(),
                              productId: product.id,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Flexible(
                      child: Text(
                        product.title,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle().copyWith(
                          fontSize: 18,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      '\$$userPrice',
                      style: const TextStyle().copyWith(
                        fontSize: 22,
                        color: color,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
