import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/wishlist_model.dart';
import 'package:grocery/core/widgets/custom_snack_bar.dart';

import '../core/utils/contants.dart';

class WishlistProvider with ChangeNotifier {
  final _fireStore = FirebaseFirestore.instance;
  final Map<String, WishlistModel> wishlistItems = {};

  bool isInWishlist(String productId) => wishlistItems.keys.contains(productId);
  WishlistModel wishItemById(String productId) =>
      wishlistItems.values.firstWhere((item) => item.productId == productId);

  Future<void> fetchWishlist() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        wishlistItems.clear();
        return;
      }
      final documentSnapShot =
          await _fireStore.collection(usersCollection).doc(user.uid).get();

      if (!documentSnapShot.exists) {
        return;
      }

      final List<dynamic> items = documentSnapShot['userWish'];

      for (final item in items) {
        wishlistItems.putIfAbsent(
            item['productId'] as String,
            () => WishlistModel.fromJson(
                  item,
                ));
      }

      print('got wishlist successfully');
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> handleClick(
      {required WishlistModel wishlistModel,
      required BuildContext context}) async {
    try {
      if (isInWishlist(wishlistModel.productId)) {
        await deleteItem(wishlistModel: wishlistModel);
      } else {
        await addToWishlist(wishlistModel: wishlistModel);
      }
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: e.message ?? 'Oops, error occurred, try later',
            icon: Icons.error,
            backgroundColor: Colors.red,
          ),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: e.toString(),
            icon: Icons.error,
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> addToWishlist({required WishlistModel wishlistModel}) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      await _fireStore.collection(usersCollection).doc(user!.uid).update(
        {
          'userWish': FieldValue.arrayUnion([
            wishlistModel.toJson(),
          ]),
        },
      );

      wishlistItems.putIfAbsent(
        wishlistModel.productId,
        () => wishlistModel,
      );

      notifyListeners();
      print('add the iem to firebase wishlist successfully');
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> clearWishlist() async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await _fireStore.collection(usersCollection).doc(user!.uid).update(
        {
          'userWish': [],
        },
      );

      wishlistItems.clear();

      notifyListeners();
      print('clear the cart from firebase successfully');
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteItem({required WishlistModel wishlistModel}) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      await _fireStore.collection(usersCollection).doc(user!.uid).update(
        {
          'userCart': FieldValue.arrayRemove([
            wishlistModel.toJson(),
          ]),
        },
      );

      wishlistItems.remove(wishlistModel.productId);
      notifyListeners();

      print('remove the item from firebase wishlist successfully');
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
