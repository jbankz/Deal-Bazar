import 'package:flutter/material.dart';

class MobileInfo with ChangeNotifier {
  double _height = 1.0;
  double _width = 1.0;

  double get mobileHeight => _height;

  double get mobileWidth => _width;

  setHeight(double h) {
    _height = h;
    notifyListeners();
  }

  setWidth(double w) {
    _width = w;
    notifyListeners();
  }
}
