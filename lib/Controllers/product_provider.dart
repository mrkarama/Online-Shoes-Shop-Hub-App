import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  int _pageIndex = 0;
  List<dynamic> listOfSizes = [];

  int get pageIndex => _pageIndex;
  List<dynamic> get getListOfSizes => listOfSizes;

  void setPageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  void setListOfSizes(List<dynamic> sizes) {
    listOfSizes = sizes;
    notifyListeners();
  }

  void toggleIsSelected(int index, bool value) {
    for (int i = 0; i < listOfSizes.length; i++) {
      if (i == index) {
        listOfSizes[i]['isSelected'] = value;
        notifyListeners();
      }
    }
    notifyListeners();
  }
}
