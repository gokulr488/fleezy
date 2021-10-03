import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  List<ModelVehicle> _availableVehicles = <ModelVehicle>[];
  final Map<String, List<ModelTrip>> _tripHistory = <String, List<ModelTrip>>{};
  Map<String, List<ModelTrip>> _pendingBalance = <String, List<ModelTrip>>{};
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

  List<ModelTrip> getPendingBalanceOf(String regNo) {
    return _pendingBalance[regNo];
  }

  List<ModelTrip> getAllPendingBalances() {
    final List<ModelTrip> pendingBals = <ModelTrip>[];
    for (final ModelVehicle vehicle in _availableVehicles) {
      pendingBals
          .addAll(_pendingBalance[vehicle.registrationNo] ?? <ModelTrip>[]);
    }
    return pendingBals;
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

  void addPendingBalance(String regNo, ModelTrip pendingBal) {
    if (_pendingBalance[regNo] == null) {
      _pendingBalance[regNo] = <ModelTrip>[];
    }
    _pendingBalance[regNo].add(pendingBal);
    notifyListeners();
  }

  void resetPendingBalances() {
    _pendingBalance = <String, List<ModelTrip>>{};
    notifyListeners();
  }

  void setTrip(ModelTrip trip) {
    _trip = trip;
    notifyListeners();
  }

  void addNewDriver(ModelUser user) {
    _drivers ??= <String, ModelUser>{};
    _drivers[user.phoneNumber] = user;
    notifyListeners();
  }

  void setDrivers(List<ModelUser> users) {
    _drivers ??= <String, ModelUser>{};

    for (final ModelUser user in users) {
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
    _drivers.update(user.phoneNumber, (ModelUser value) => user);
    notifyListeners();
  }
}
