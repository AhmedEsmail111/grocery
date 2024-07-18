import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/models/cart_model.dart';
import 'package:grocery/core/models/wishlist_model.dart';

class UserInfoModel with ChangeNotifier {
  final String uid, name, email, address;
  final List<WishlistModel> userWish;
  final List<CartModel> userCart;
  final Timestamp createdAt;

  UserInfoModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.address,
    required this.userWish,
    required this.userCart,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'address': address,
        'userWish': userWish,
        'userCart': userCart,
        'createdAt': createdAt,
      };

  static UserInfoModel fromJson(Map<String, dynamic> doc) {
    return UserInfoModel(
      uid: doc['uid'],
      name: doc['name'],
      email: doc['email'],
      address: doc['address'],
      userWish: doc['userWish'] is List<WishlistModel> ? doc['userWish'] : [],
      userCart: doc['userCart'] is List<CartModel> ? doc['userCart'] : [],
      createdAt: doc['createdAt'],
    );
  }
}
