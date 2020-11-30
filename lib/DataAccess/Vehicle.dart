import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';

class Vehicle {
  FirebaseFirestore fireStore;
  CallContext callContext;

  Vehicle() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  void addVehicle(ModelVehicle vehicle) async {
    if (vehicle.companyId == null) {
      print('companyId is null for the vehicle');
      return;
    }
    DocumentSnapshot snapShot = await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .get();
    if (snapShot.data() != null) {
      print("Vehicle already exists");
      return;
    }

    fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .set(ModelVehicle.getDocOf(vehicle))
        .then(callContext.setSuccess('Company added'))
        .catchError((error) => callContext.setError("$error"));

    if (callContext.isError) {
      print(callContext.errorMessage);
      return null;
    }
  }

  void updateVehicle(ModelVehicle vehicle, String companyId) async {
    DocumentSnapshot snapShot = await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .get();
    if (snapShot == null) {
      print("Vehicle not found");
      return null;
    }

    return fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .update(ModelVehicle.getDocOf(vehicle))
        .then((value) => print("Vehicle details updated"))
        .catchError((error) => print("Failed to update vehicle: $error"));
  }

  Future<List<ModelVehicle>> getVehiclesForUser(ModelUser user) async {
    if (user.companyId == null || user.phoneNumber == null) {
      print('companyId or phoneNumber is null');
      return null;
    }
    QuerySnapshot snapShot = await fireStore
        .collection(Constants.VEHICLES)
        .where('CompanyId', isEqualTo: user.companyId)
        .where('AllowedDrivers', arrayContains: user.phoneNumber)
        .get();
    if (snapShot == null) {
      print("No Vehicles Found");
      return null;
    }
    return ModelVehicle.getVehicleFrom(snapShot);
  }
}
