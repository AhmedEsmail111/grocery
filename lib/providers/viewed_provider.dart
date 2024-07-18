import 'package:flutter/material.dart';

import '../core/models/viewed_model.dart';

class ViewedProvider with ChangeNotifier {
  final Map<String, ViewedModel> _viewedItems = {};

  Map<String, ViewedModel> get viewedItems => _viewedItems;

  // bool isInWishlist(String productId) =>
  //     _viewedItems.keys.contains(productId);

  void addToViewed({required String productId}) {
    _viewedItems.putIfAbsent(
        productId,
        () => ViewedModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              productId: productId,
            ));

    notifyListeners();
  }

  void clearViewed() {
    _viewedItems.clear();

    notifyListeners();
  }

  void deleteViewed(String id) {
    _viewedItems.remove(id);
    notifyListeners();
  }
}
