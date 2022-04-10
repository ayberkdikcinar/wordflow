import 'package:flutter/material.dart';

enum MenuState { options, play, help, exit, main }

class MenuViewModel extends ChangeNotifier {
  MenuState _currentState = MenuState.main;

  void changeStatus(MenuState status) {
    _currentState = status;
    notifyListeners();
  }

  MenuState get currentMenuState {
    return _currentState;
  }
}
