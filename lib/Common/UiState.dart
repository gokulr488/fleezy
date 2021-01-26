import 'package:flutter/cupertino.dart';

class UiState extends ChangeNotifier {
  bool _isAdmin = false;

//SETTERS
  void setIsAdmin(bool value) {
    _isAdmin = value;
    notifyListeners();
  }

//GETTERS
  bool get isAdmin => _isAdmin;
}
