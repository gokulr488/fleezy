import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

class ModelVehicle {
  final String vehicleName;
  final String registrationNo;
  final String brand;
  final Timestamp taxExpiryDate;
  final Timestamp insuranceExpiryDate;
  final int latestOdometerReading;
  final bool isInTrip;
  final List<String> allowedDrivers;
  final List<ModelTrip> trips;

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
