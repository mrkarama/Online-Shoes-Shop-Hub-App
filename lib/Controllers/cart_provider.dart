import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_app/Models/shoe_cart_model.dart';

class CartProvider extends ChangeNotifier {
  Box<CartModel> box = Hive.box<CartModel>('cart_box');
  Box<dynamic> total_box = Hive.box('total_box');

  double _total = 0;

  double get getTotal => _total;

  void setTotal(double n) {
    _total = n;
    notifyListeners();
  }

  void addToCart(CartModel product, double number) async {
    box.add(product);
    _total = _total + number;
    total_box.put('total', _total);
    print('price isss ${total_box.get('total')}');
    setTotal(total_box.get('total') ?? 0);
    notifyListeners();
  }

  void removeToCart(BuildContext context, int key, double number) async {
    box.delete(key);
    _total -= number;
    total_box.put('total', _total);
    setTotal(total_box.get('total') ?? 0);
    print('price isss ${total_box.get('total')}');
    notifyListeners();
  }
}
