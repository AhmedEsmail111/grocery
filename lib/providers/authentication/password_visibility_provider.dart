import 'package:flutter/material.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool _hidPassword = true;

  bool get hidePassword => _hidPassword;
  void changeAutoValidateMode() {
    autovalidateMode = AutovalidateMode.always;
  }

  void changePasswordVisibility() {
    _hidPassword = !_hidPassword;
    notifyListeners();
  }
}
