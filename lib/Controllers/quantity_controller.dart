import 'package:flutter/material.dart';

class QuantityController extends ChangeNotifier {
  int _quantity = 1;

  int get quantity => _quantity;

  void incrementQty() {
    _quantity++;
    notifyListeners();
  }

  void decrementQty() {
    _quantity--;
    notifyListeners();
  }
}
