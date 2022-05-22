import 'package:deal_bazaar/Core/Constants/Colors.dart';
import 'package:flutter/material.dart';

class WebBottomNav extends StatelessWidget {
  final Function(int index)? onTap;
  const WebBottomNav({required this.onTap, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 30,
      backgroundColor: yellowColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(color: Colors.black),
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.refresh), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.arrow_forward), label: ''),
      ],
    );
  }
}
