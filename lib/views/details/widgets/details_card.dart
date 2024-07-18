import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/widgets/favorite_button.dart';
import 'package:grocery/providers/product_quantity_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/views/details/widgets/total_row.dart';
import 'package:provider/provider.dart';

import '../../../core/models/product.dart';
import '../../../core/models/wishlist_model.dart';
import '../../cart/widgets/change_quantity_icon.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    final product = Provider.of<Product>(context);
    final quantityProvider = Provider.of<ProductQuantityProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: const TextStyle().copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 25,
                  ),
                ),
                FavoriteButton(
                  wishlistModel: WishlistModel(
                    id: Timestamp.now().microsecondsSinceEpoch.toString(),
                    productId: product.id,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: '\$ ${product.salePrice}',
                    style: const TextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.green,
                    ),
                    children: [
                      TextSpan(
                        text: product.isPiece ? '/Piece  ' : '/kg   ',
                        style: const TextStyle().copyWith(
                          color: color,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                      if (product.isOnSale)
                        TextSpan(
                          text: '\$${product.price}',
                          style: const TextStyle().copyWith(
                            color: isDark ? Colors.white60 : Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(63, 200, 101, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Text(
                      'Free delivery',
                      style: const TextStyle().copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeQuantityIcon(
                icon: CupertinoIcons.minus,
                backgroundColor: Colors.red,
                onTap: quantityProvider.decreaseQuantity,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                children: [
                  Text(
                    quantityProvider.quantity.toString(),
                    style:
                        const TextStyle().copyWith(color: color, fontSize: 16),
                  ),
                  Container(
                    color: isDark ? Colors.white60 : Colors.black54,
                    width: 50,
                    height: 1,
                  ),
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              ChangeQuantityIcon(
                icon: CupertinoIcons.add,
                backgroundColor: Colors.green,
                onTap: quantityProvider.increaseQuantity,
              )
            ],
          ),
          const Spacer(),
          const TotalRow()
        ],
      ),
    );
  }
}
