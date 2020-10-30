import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

class ModelVehicle {
  String vehicleName;
  String registrationNo;
  String brand;
  Timestamp taxExpiryDate;
  Timestamp insuranceExpiryDate;
  int latestOdometerReading;
  bool isInTrip;
  List<String> allowedDrivers;
  List<ModelTrip> trips;

  ModelVehicle(
      {this.vehicleName,
      this.registrationNo,
      this.brand,
      this.taxExpiryDate,
      this.insuranceExpiryDate,
      this.latestOdometerReading,
      this.isInTrip,
      this.trips,
      this.allowedDrivers});
}
