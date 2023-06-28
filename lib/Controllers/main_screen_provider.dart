import 'package:flutter/material.dart';

class MainScreenProvider extends ChangeNotifier {
  int _pageIndex = 0;

  int get getPageIndex => _pageIndex;

  void onPageChanged(int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }
}
