import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery/core/utils/contants.dart';

import '../core/models/product.dart';

class ProductsProvider with ChangeNotifier {
  final _fireStore = FirebaseFirestore.instance;
  final productsList = <Product>[];
  final searchedProducts = <Product>[];
  String searchControllertext = '';

  List<Product> get getOnSaleProducts =>
      productsList.where((product) => product.isOnSale).toList();

  List<Product> categoryProducts(String catName) {
    return productsList
        .where(
          (product) => product.productCategory
              .toLowerCase()
              .contains(catName.toLowerCase()),
        )
        .toList();
  }

  List<Product> loadSpecificProductsByIds(List<String> productsIds) {
    final List<Product> products = [];
    for (final item in productsIds) {
      products.add(
        productsList.firstWhere(
          (product) => product.id == item,
        ),
      );
    }
    return products;
  }

  void setUpValues() {
    searchControllertext = '';
    searchedProducts.clear();
    notifyListeners();
  }

  void querySearchedProducts(String query) {
    searchedProducts.clear();
    notifyListeners();
    final iterable = productsList.where(
      (product) => product.title.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );
    searchedProducts.addAll(iterable);
    notifyListeners();
  }

  void queryCategorySearchedProducts(String query, String catName) {
    searchedProducts.clear();
    notifyListeners();
    final iterable = categoryProducts(catName).where(
      (product) => product.title.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );
    searchedProducts.addAll(iterable);
    notifyListeners();
  }

  void saveSearchText(String searchText) {
    searchControllertext = searchText;
    notifyListeners();
  }

  Product productById(String productId) =>
      productsList.firstWhere((product) => product.id == productId);

  Future<void> fetchProducts(BuildContext context) async {
    try {
      final snapshot = await _fireStore.collection(productsCollection).get();
      if (snapshot.docs.isNotEmpty) {
        productsList.clear();
        for (final doc in snapshot.docs) {
          productsList.add(
            Product.fromJson(
              doc.data(),
            ),
          );
        }
        print('got products successfully');
        notifyListeners();
      } else {}
    } on FirebaseException catch (e) {
      print(e.message);
      // TODO
    } catch (e) {
      // TODO
      print(e.toString());
    }
  }
}
