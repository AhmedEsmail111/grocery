import 'package:flutter/material.dart';

class WishlistModel with ChangeNotifier {
  final String id, productId;

  WishlistModel({required this.id, required this.productId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
    };
  }

  factory WishlistModel.fromJson(Map<String, dynamic> json) =>
      WishlistModel(id: json['id'], productId: json['productId']);
}
