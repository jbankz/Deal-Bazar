import 'package:flutter/material.dart';

class DrawerModel with ChangeNotifier {
  int _drawerNo = 1;
  int get drawerNo => _drawerNo;

  void page1() {
    _drawerNo = 1;
    notifyListeners();
  }

  void page2() {
    _drawerNo = 2;
    notifyListeners();
  }

  void page3() {
    _drawerNo = 3;
    notifyListeners();
  }

  void page4() {
    _drawerNo = 4;
    notifyListeners();
  }

  void page5() {
    _drawerNo = 5;
    notifyListeners();
  }

  void page6() {
    _drawerNo = 6;
    notifyListeners();
  }

  void page7() {
    _drawerNo = 7;
    notifyListeners();
  }

  void page8() {
    _drawerNo = 8;
    notifyListeners();
  }
}
