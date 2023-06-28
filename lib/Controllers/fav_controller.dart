import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavController extends ChangeNotifier {
  Box<dynamic> fav_box = Hive.box('fav_box');

  List<dynamic> _ids = [];
  List<dynamic> get getIds => _ids;

  void setIds() {
    List<int> keys = fav_box.keys.cast<int>().toList();
    _ids = keys.map((key) => fav_box.get(key)['id']).toList();
    notifyListeners();
  }

  void removeIds(int key) {
    _ids.removeAt(key);
    notifyListeners();
  }

  Future<void> addToFavBox(Map<String, dynamic> product) async {
    await fav_box.add(product);
    notifyListeners();
  }

  Future<void> removeToFavBox(int key) async {
    await fav_box.delete(key);
    notifyListeners();
  }
}
