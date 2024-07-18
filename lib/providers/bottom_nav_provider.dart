import 'package:flutter/material.dart';

class BottomNavProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeNavBarScreen(int newScreen) {
    _currentIndex = newScreen;

    notifyListeners();
  }
}
