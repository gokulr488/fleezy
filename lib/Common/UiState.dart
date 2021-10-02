import 'package:flutter/cupertino.dart';

class UiState extends ChangeNotifier {
  bool _isAdmin = true;

  //GETTERS
  bool get isAdmin => _isAdmin;

//SETTERS
  void setIsAdmin({bool isAdmin}) {
    _isAdmin = isAdmin;
    notifyListeners(); //uncomment this if admin switching is not happening
  }
}
