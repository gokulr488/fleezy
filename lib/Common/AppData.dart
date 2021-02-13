import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  //int _bottomNavBarIndex = 1;
  List<ModelVehicle> _availableVehicles = [];
  ModelUser _user;

  //GETTERS
  List<ModelVehicle> get availableVehicles => _availableVehicles;
  //int get bottomNavBarIndex => _bottomNavBarIndex;
  ModelUser get user => _user;
  //SETTERS
  void setUser(ModelUser user) {
    _user = user;
    notifyListeners();
  }

  void addNewVehicle(ModelVehicle vehicle) {
    _availableVehicles.add(vehicle);
    notifyListeners();
  }

  void setAvailableVehicles(List<ModelVehicle> vehicles) {
    _availableVehicles = vehicles;
    notifyListeners();
  }
//   void setBottomNavBarIndex(int index) {
//     _bottomNavBarIndex = index;
//     notifyListeners();
//   }
}
