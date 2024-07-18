import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/cart_model.dart';
import 'package:grocery/core/widgets/fancy_image.dart';
import 'package:grocery/core/widgets/favorite_button.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/views/cart/widgets/change_quantity_icon.dart';
import 'package:provider/provider.dart';

import '../../../core/models/wishlist_model.dart';
import '../../../core/utils/functions.dart';
import '../../../providers/products_provider.dart';
import '../../../providers/viewed_provider.dart';
import '../../details/product_details_view.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItem = Provider.of<CartModel>(context);
    final product =
        Provider.of<ProductsProvider>(context).productById(cartItem.productId);

    final viewedProvider = Provider.of<ViewedProvider>(context);
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    final width = MediaQuery.sizeOf(context).width;

    final userPrice = product.isOnSale ? product.salePrice : product.price;
    final itemPrice = (userPrice * cartItem.quantity).toStringAsFixed(2);
    print(cartItem.id);
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor.withOpacity(0.4),
      child: GestureDetector(
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
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              FancyImage(
                imageUrl: product.imageUrl,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle().copyWith(
                      fontSize: 20,
                      color: color,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      ChangeQuantityIcon(
                        icon: CupertinoIcons.minus,
                        backgroundColor: Colors.red,
                        onTap: () {
                          if (cartItem.quantity > 1) {
                            cartProvider.updateQuantity(
                              productId: cartItem.productId,
                              quantity: cartItem.quantity - 1,
                            );
                          } else {
                            showAlertDialogue(
                              context: context,
                              title: 'Delete Item',
                              content: 'The item will be deleted permanently!',
                              onPressed: () {
                                cartProvider.deleteItem(
                                    cartModel: cartItem, context: context);
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            cartItem.quantity.toString(),
                            style: const TextStyle()
                                .copyWith(color: color, fontSize: 16),
                          ),
                          Container(
                            color: isDark ? Colors.white60 : Colors.black54,
                            width: 20,
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
                        onTap: () {
                          cartProvider.updateQuantity(
                            productId: cartItem.productId,
                            quantity: cartItem.quantity + 1,
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      showAlertDialogue(
                        context: context,
                        title: 'Delete Item',
                        content: 'The item will be deleted permanently!',
                        onPressed: () {
                          cartProvider.deleteItem(
                              cartModel: cartItem, context: context);
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                    child: const Icon(
                      CupertinoIcons.cart_badge_minus,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  FavoriteButton(
                    wishlistModel: WishlistModel(
                      id: Timestamp.now().microsecondsSinceEpoch.toString(),
                      productId: product.id,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '\$$itemPrice',
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle().copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
