import 'package:flutter/cupertino.dart';

class UiState extends ChangeNotifier {
  bool _isAdmin = false;

  //GETTERS
  bool get isAdmin => _isAdmin;

//SETTERS
  void setIsAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }
}
