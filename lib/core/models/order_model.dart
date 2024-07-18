import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'product.dart';

class OrderModel with ChangeNotifier {
  final String orderId, userId, userName;
  final double totalPrice;
  final List<Product> products;
  final List<int> quantities;
  final Timestamp orderDate;

  OrderModel({
    required this.userId,
    required this.userName,
    required this.quantities,
    required this.orderId,
    required this.products,
    required this.totalPrice,
    required this.orderDate,
  });

  Map<String, dynamic> toJson() {
    final encodedProducts = <Map<String, dynamic>>[];
    for (final product in products) {
      encodedProducts.add(product.toJson());
    }
    return {
      'oderId': orderId,
      'userId': userId,
      'userName': userName,
      'products': encodedProducts,
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'quantities': quantities,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final decodedProducts = <Product>[];
    for (final product in json['products']) {
      decodedProducts.add(
        Product.fromJson(product),
      );
    }
    return OrderModel(
      orderId: json['oderId'],
      userId: json['userId'],
      userName: json['userName'],
      products: decodedProducts,
      totalPrice: json['totalPrice'],
      orderDate: json['orderDate'],
      quantities: List<int>.from(json['quantities']),
    );
  }
}
