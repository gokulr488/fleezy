import 'package:cloud_firestore/cloud_firestore.dart';
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
      this.companyId});

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
    };
  }

  static ModelVehicle getVehicleFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelVehicle(
      vehicleName: data['VehicleName'] ?? '',
      registrationNo: data['RegistrationNo'] ?? '',
      brand: data['Brand'] ?? '',
      taxExpiryDate: data['TaxExpiryDate'] ?? '',
      insuranceExpiryDate: data['InsuranceExpiryDate'] ?? '',
      latestOdometerReading: data['LatestOdometerReading'] ?? '',
      isInTrip: data['IsInTrip'] ?? '',
      trips: data['Trips'] ?? '',
      currentDriver: data['CurrentDriver'],
      allowedDrivers: data['AllowedDrivers'],
      companyId: data['CompanyId'],
    );
  }

  static List<ModelVehicle> getVehicleFrom(QuerySnapshot snapshot) {
    List<ModelVehicle> users = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      users.add(getVehicleFromDoc(doc));
    }
    return users;
  }

  static ModelVehicle getUserFromSnapshot(QuerySnapshot snapshot) {
    QueryDocumentSnapshot doc = snapshot.docs.first;
    return getVehicleFromDoc(doc);
  }
}
