import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

class ModelVehicle {
  String vehicleName;
  String registrationNo;
  String brand;
  String currentDriver;
  Timestamp taxExpiryDate;
  Timestamp insuranceExpiryDate;
  int latestOdometerReading;
  String companyId;
  bool isInTrip;
  List<String> allowedDrivers;
  List<ModelTrip> trips;
  double avgMileage;

  ModelVehicle(
      {this.vehicleName,
      this.registrationNo,
      this.brand,
      this.taxExpiryDate,
      this.insuranceExpiryDate,
      this.latestOdometerReading,
      this.isInTrip,
      this.trips,
      this.allowedDrivers,
      this.currentDriver,
      this.companyId,
      this.avgMileage});

  static Map<String, dynamic> getDocOf(ModelVehicle vehicle) {
    return {
      'VehicleName': vehicle.vehicleName,
      'RegistrationNo': vehicle.registrationNo,
      'Brand': vehicle.brand,
      'TaxExpiryDate': vehicle.taxExpiryDate,
      'InsuranceExpiryDate': vehicle.insuranceExpiryDate,
      'LatestOdometerReading': vehicle.latestOdometerReading,
      'IsInTrip': vehicle.isInTrip,
      'Trips': vehicle.trips,
      'CurrentDriver': vehicle.currentDriver,
      'AllowedDrivers': vehicle.allowedDrivers,
      'CompanyId': vehicle.companyId,
      'AvgMileage': vehicle.avgMileage
    };
  }

  static ModelVehicle getVehicleFromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data();

    return ModelVehicle(
      vehicleName: data['VehicleName'] ?? '',
      registrationNo: data['RegistrationNo'] ?? '',
      brand: data['Brand'] ?? '',
      taxExpiryDate: data['TaxExpiryDate'],
      insuranceExpiryDate: data['InsuranceExpiryDate'],
      latestOdometerReading: data['LatestOdometerReading'] ?? 0,
      isInTrip: data['IsInTrip'] ?? false,
      trips: List<ModelTrip>.from(data['Trips'] ?? []),
      currentDriver: data['CurrentDriver'] ?? '',
      allowedDrivers: List<String>.from(data['AllowedDrivers'] ?? []),
      companyId: data['CompanyId'] ?? '',
      avgMileage: data['AvgMileage'] ?? 0,
    );
  }

  static List<ModelVehicle> getVehicleFrom(QuerySnapshot snapshot) {
    List<ModelVehicle> vehicles = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      vehicles.add(getVehicleFromDoc(doc));
    }
    return vehicles;
  }

  static ModelVehicle getUserFromSnapshot(QuerySnapshot snapshot) {
    QueryDocumentSnapshot doc = snapshot.docs.first;
    return getVehicleFromDoc(doc);
  }

  static String getWarningMessage(ModelVehicle vehicle) {
    String warning = '';
    if (Utils.isWarningPeriod(vehicle.insuranceExpiryDate)) {
      warning =
          'Insurance Expires on ${Utils.getFormattedTimeStamp(vehicle.insuranceExpiryDate, kDateFormat)}. ';
    }
    if (Utils.isWarningPeriod(vehicle.taxExpiryDate)) {
      warning = warning +
          'Tax Expires on ${Utils.getFormattedTimeStamp(vehicle.taxExpiryDate, kDateFormat)}';
    }
    return warning;
  }
}
