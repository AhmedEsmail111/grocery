import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery/core/widgets/empty_screen.dart';
import 'package:grocery/providers/theme_provider.dart';
import 'package:grocery/providers/wishlist_provider.dart';
import 'package:grocery/views/wishlist/widgets/whishlist_grid_view.dart';
import 'package:provider/provider.dart';

import '../../core/utils/functions.dart';
import '../../core/widgets/back_button.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final color = isDark ? Colors.white : Colors.black;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItems = wishlistProvider.wishlistItems.values.toList();
    return wishlistItems.isEmpty
        ? const EmptyScreen(
            imagePath: 'assets/images/wishlist.png',
            content:
                'Your Wishlist is empty\nExplore more and shortlist some items',
            buttonText: 'Add a wish',
          )
        : Scaffold(
            appBar: AppBar(
              leading: const CustomBackButton(),
              title: Text(
                'Wishlist(${wishlistItems.length})',
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    showAlertDialogue(
                      context: context,
                      title: 'Clear Wishlist',
                      content: 'Your wishlist will be cleared!',
                      onPressed: () {
                        wishlistProvider.clearWishlist();
                      },
                    );
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ),
                ),
              ],
            ),
            body: const WishlistGridView(),
          );
  }
}
