import 'package:flutter/cupertino.dart';

class UiState extends ChangeNotifier {
  final Map<int, String> screenHeaderMap = {
    0: 'Manage Company',
    1: 'Our Vehicles',
    2: 'User Info'
  };
  bool _isAdmin = false;
  int _bottomNavBarIndex = 1;

  //GETTERS
  bool get isAdmin => _isAdmin;
  int get bottomNavBarIndex => _bottomNavBarIndex;

//SETTERS
  void setIsAdmin(bool value) {
    _isAdmin = value;
    //notifyListeners(); uncomment this if admin switching is not happening
  }

  void setBottomNavBarIndex(int index) {
    _bottomNavBarIndex = index;
    notifyListeners();
  }
}
