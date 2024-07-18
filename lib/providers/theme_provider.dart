import 'package:flutter/material.dart';
import 'package:grocery/core/utils/contants.dart';
import 'package:grocery/core/utils/services/shared_prefers.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = CacheHelper.getData(key: kThemeMode) ?? false;

  bool get isDark => _isDark;
  void setDartMode(bool value) {
    _isDark = value;
    CacheHelper.saveData(key: kThemeMode, value: value);
    notifyListeners();
  }
}
