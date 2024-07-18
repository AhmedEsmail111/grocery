import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/models/product.dart';
import 'package:grocery/core/widgets/fancy_image.dart';
import 'package:grocery/providers/cart_provider.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/views/details/product_details_view.dart';
import 'package:provider/provider.dart';

import '../../providers/viewed_provider.dart';
import '../models/cart_model.dart';
import '../models/wishlist_model.dart';
import 'error_dialogue.dart';
import 'favorite_button.dart';

class ProductCardItem extends StatefulWidget {
  const ProductCardItem({
    super.key,
  });

  @override
  State<ProductCardItem> createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().isDark;
    final width = MediaQuery.sizeOf(context).width;
    final color = isDark ? Colors.white : Colors.black;

    final product = Provider.of<Product>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor.withOpacity(0.9),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
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
          child: Column(
            children: [
              FancyImage(
                imageUrl: product.imageUrl,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Text(
                      product.title,
                      style: const TextStyle().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: FavoriteButton(
                      wishlistModel: WishlistModel(
                        id: Timestamp.now().microsecondsSinceEpoch.toString(),
                        productId: product.id,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      product.isOnSale
                          ? '\$${product.salePrice}'
                          : '\$${product.price}',
                      style: const TextStyle().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        product.isPiece ? 'piece $_quantity' : 'kg $_quantity',
                        style: const TextStyle().copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: color,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        child: Icon(
                          IconlyLight.plus,
                          size: 22,
                          color: color,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).cardColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    if (user == null) {
                      showDialog(
                        context: context,
                        builder: (_) => const CustomErrorDialogue(
                          contentText: 'No user found! please log in first.',
                        ),
                      );
                      return;
                    }
                    if (!cartProvider.isInCart(product.id)) {
                      final cartModel = CartModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        productId: product.id,
                        quantity: _quantity,
                      );
                      cartProvider.addToCart(
                        cartModel: cartModel,
                        context: context,
                      );
                    }
                  },
                  child: Text(
                    cartProvider.isInCart(product.id)
                        ? 'In cart'
                        : 'Add to cart',
                    style: const TextStyle().copyWith(
                      color: color,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
