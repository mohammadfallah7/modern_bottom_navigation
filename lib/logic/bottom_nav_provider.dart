import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int selectedScreenIndex = 0;

  void toggleScreenIndex(int index) {
    selectedScreenIndex = index;

    notifyListeners();
  }
}
