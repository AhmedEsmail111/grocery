import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grocery/core/utils/contants.dart';
import 'package:grocery/core/utils/services/stripe_service.dart';
import 'package:grocery/core/widgets/custom_snack_bar.dart';

import '../core/models/order_model.dart';
import '../core/models/payment/payment_intent_input_model.dart';
import '../core/utils/services/api_service.dart';

class OrdersProvider with ChangeNotifier {
  final _stripeService = StripeService(apiService: ApiService(dio: Dio()));
  final _fireStore = FirebaseFirestore.instance;
  List<OrderModel> orders = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> makeStripePayment(
      {required PaymentIntentInputModel paymentIntentInputModel,
      required BuildContext context}) async {
    try {
      await _stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return true;
    } on StripeException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: e.toString(),
            backgroundColor: Colors.red,
            icon: Icons.done,
          ),
        );
      }
      return false;
    }
  }

  Future<void> placeOrder(
      {required OrderModel orderModel, required BuildContext context}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _fireStore.collection(ordersCollection).doc(orderModel.orderId).set(
            orderModel.toJson(),
          );

      orders.add(orderModel);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          buildCustomSnackBar(
            context: context,
            message: 'The order has been placed successfully',
            icon: Icons.done,
          ),
        );
      }
      Future.delayed(const Duration(seconds: 2), () {
        _isLoading = false;
      });

      notifyListeners();
      print('add the order to firebase successfully');
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

  Future<void> fetchOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      orders.clear();
      return;
    }
    try {
      final querySnapshot = await _fireStore.collection(ordersCollection).get();

      if (querySnapshot.docs.isNotEmpty) {
        for (final order in querySnapshot.docs) {
          if (order['userId'] == user.uid) {
            orders.add(
              OrderModel.fromJson(
                order.data(),
              ),
            );
          }
        }
        print('got orders successfully');
      }
    } on FirebaseException catch (e) {}
  }
}
