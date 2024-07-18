import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/cart_model.dart';
import 'package:grocery/core/utils/contants.dart';

import '../core/widgets/custom_snack_bar.dart';

class CartProvider with ChangeNotifier {
  final _fireStore = FirebaseFirestore.instance;

  final Map<String, CartModel> cartItems = {};
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool isInCart(String productId) => cartItems.keys.contains(productId);

  Future<void> fetchCart() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        cartItems.clear();
        return;
      }
      final documentSnapShot =
          await _fireStore.collection(usersCollection).doc(user.uid).get();

      if (!documentSnapShot.exists) {
        return;
      }

      final List<dynamic> items = documentSnapShot['userCart'];

      for (final item in items) {
        cartItems.putIfAbsent(
            item['productId'] as String,
            () => CartModel.fromJson(
                  item,
                ));
      }

      print('got cart successfully');
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> addToCart(
      {required CartModel cartModel, required BuildContext context}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await _fireStore.collection(usersCollection).doc(user!.uid).update(
        {
          'userCart': FieldValue.arrayUnion([
            cartModel.toJson(),
          ]),
        },
      );

      cartItems.putIfAbsent(
        cartModel.productId,
        () => CartModel(
          id: cartModel.id,
          productId: cartModel.productId,
          quantity: cartModel.quantity,
        ),
      );
      notifyListeners();
      print('add the iem to firebase successfully');
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

  void clearCart(
      {required BuildContext context, bool canShowSnackBar = true}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      _isLoading = true;
      notifyListeners();
      await _fireStore.collection(usersCollection).doc(user!.uid).update(
        {
          'userCart': [],
        },
      );

      cartItems.clear();
      notifyListeners();
      if (context.mounted && canShowSnackBar) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: 'The Cart was erased permanently',
            icon: Icons.done,
          ),
        );
      }
      print('clear the cart from firebase successfully');
      _isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.message);
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
      _isLoading = false;
      notifyListeners();
      print(e.toString());
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

  void updateQuantity({
    required String productId,
    required int quantity,
  }) {
    cartItems.update(
      productId,
      (cart) => CartModel(
        id: cart.id,
        productId: productId,
        quantity: quantity,
      ),
    );

    notifyListeners();
  }

  void deleteItem(
      {required CartModel cartModel, required BuildContext context}) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      _isLoading = true;
      notifyListeners();
      await _fireStore.collection(usersCollection).doc(user!.uid).update(
        {
          'userCart': FieldValue.arrayRemove([
            cartModel.toJson(),
          ]),
        },
      );

      cartItems.remove(
        cartModel.productId,
      );
      notifyListeners();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: 'The Item was removed successfully',
            icon: Icons.done,
          ),
        );
      }
      print('remove the item from firebase successfully');
      _isLoading = false;
      notifyListeners();
    } on FirebaseException catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.message);
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
      _isLoading = false;
      notifyListeners();
      print(e.toString());
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
}
