import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/models/wishlist_model.dart';
import 'package:grocery/core/widgets/error_dialogue.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.wishlistModel});

  final WishlistModel wishlistModel;
  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemeProvider>().isDark;
    final color = isDark ? Colors.white : Colors.black;

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    // if this item  is already in the wishlist then we fetch it and pass it
    final wishItem = wishlistProvider.isInWishlist(wishlistModel.productId)
        ? wishlistProvider.wishItemById(wishlistModel.productId)
        : null;
    return InkWell(
      onTap: () {
        if (user == null) {
          showDialog(
            context: context,
            builder: (_) => const CustomErrorDialogue(
              contentText: 'No user found! please log in first.',
            ),
          );
          return;
        }
        wishlistProvider.handleClick(
          wishlistModel: wishItem ?? wishlistModel,
          context: context,
        );
      },
      child: Icon(
        wishlistProvider.isInWishlist(wishlistModel.productId)
            ? IconlyBold.heart
            : IconlyLight.heart,
        size: 22,
        color: wishlistProvider.isInWishlist(wishlistModel.productId)
            ? Colors.red
            : color,
      ),
    );
  }
}
