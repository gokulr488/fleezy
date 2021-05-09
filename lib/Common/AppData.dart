import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  List<ModelVehicle> _availableVehicles = [];
  Map<String, List<ModelTrip>> _tripHistory = {};
  Map<String, ModelUser> _drivers;
  ModelUser _user;
  ModelTrip _trip;

  //GETTERS
  List<ModelVehicle> get availableVehicles => _availableVehicles;
  List<ModelUser> get drivers => _drivers?.values?.toList();
  ModelUser get user => _user;
  ModelTrip get trip => _trip;

  List<ModelTrip> getTripHistoryOf(String regNo) {
    return _tripHistory[regNo];
  }

  //SETTERS

  void setUser(ModelUser user) {
    _user = user;
    notifyListeners();
  }

  void setTripHistory(String regNo, List<ModelTrip> tripHistory) {
    _tripHistory[regNo] = tripHistory;
    notifyListeners();
  }

  void setTrip(ModelTrip trip) {
    _trip = trip;
    notifyListeners();
  }

  void addNewDriver(ModelUser user) {
    if (_drivers == null) {
      _drivers = {};
    }
    _drivers[user.phoneNumber] = user;
    notifyListeners();
  }

  void setDrivers(List<ModelUser> users) {
    if (_drivers == null) {
      _drivers = {};
    }
    for (ModelUser user in users) {
      _drivers[user.phoneNumber] = user;
    }
    notifyListeners();
  }

  void addNewVehicle(ModelVehicle vehicle) {
    _availableVehicles.add(vehicle);
    notifyListeners();
  }

  void deleteVehicle(ModelVehicle vehicle) {
    _availableVehicles.remove(vehicle);
    notifyListeners();
  }

  void setAvailableVehicles(List<ModelVehicle> vehicles) {
    _availableVehicles = vehicles;
    notifyListeners();
  }

  void updateDriver(ModelUser user) {
    _drivers.update(user.phoneNumber, (value) => user);
    notifyListeners();
  }
}
