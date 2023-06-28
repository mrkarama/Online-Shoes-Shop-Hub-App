import 'package:flutter/material.dart';

class TextFieldController extends ChangeNotifier {
  bool _isPassVisible = false;

  bool get isPassVisible => _isPassVisible;

  void setVisibility() {
    _isPassVisible = !isPassVisible;
    notifyListeners();
  }
}
