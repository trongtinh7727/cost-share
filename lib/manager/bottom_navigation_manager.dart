import 'package:flutter/material.dart';

class BottomNavigationManager extends ChangeNotifier {
  int _selectedTabIndex = 0;

  int get selectedTabIndex => _selectedTabIndex;

  void updateTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }
}
