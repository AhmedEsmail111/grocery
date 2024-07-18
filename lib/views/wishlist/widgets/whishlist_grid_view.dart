import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/wishlist_provider.dart';
import 'wishlist_item.dart';

class WishlistGridView extends StatelessWidget {
  const WishlistGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItems = wishlistProvider.wishlistItems.values.toList();
    return GridView.builder(
      itemCount: wishlistItems.length,
      padding: const EdgeInsets.only(
        top: 20,
        left: 12,
        right: 12,
        bottom: 12,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: height / height * 1.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            value: wishlistItems[index],
            child: const WishListItem(),
          )),
    );
  }
}
