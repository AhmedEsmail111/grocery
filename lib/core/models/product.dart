import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id, title, productCategory, imageUrl, createdAt;
  final double price, salePrice;
  final bool isOnSale, isPiece;

  Product({
    required this.id,
    required this.title,
    required this.productCategory,
    required this.imageUrl,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
    required this.isPiece,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        productCategory: json['productCategory'],
        imageUrl: json['imageUrl'],
        price: json['price'].toDouble(),
        salePrice: json['salePrice'].toDouble(),
        isOnSale: json['isOnSale'],
        isPiece: json['isPiece'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isPiece': isPiece,
      'productCategory': productCategory,
      'imageUrl': imageUrl,
      'price': price,
      'salePrice': salePrice,
      'isOnSale': isOnSale,
      'createdAt': createdAt,
    };
  }
}
