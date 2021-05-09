import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
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

  Future<CallContext> addVehicle(ModelVehicle vehicle) async {
    if (vehicle.companyId == null) {
      callContext.setError('companyId is null for the vehicle');
      return callContext;
    }
    DocumentReference docRef = await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo);
    if (docRef != null) {
      callContext.setError("Vehicle already exists");
      return callContext;
    }

    await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .set(ModelVehicle.getDocOf(vehicle))
        .then((value) => callContext.setSuccess('Vehicle added'))
        .catchError((error) => callContext.setError("$error"));

    return callContext;
  }

  Future<String> deleteVehicle(ModelVehicle vehicle) async {
    try {
      await fireStore
          .collection(Constants.VEHICLES)
          .doc(vehicle.registrationNo)
          .delete();
      return 'Deleted ${vehicle.registrationNo} from company';
    } catch (e) {
      print('Unable to delete ${vehicle.registrationNo}');
      print(e);
      return 'Unable to delete ${vehicle.registrationNo}';
    }
  }

  Future<CallContext> updateVehicle(ModelVehicle vehicle) async {
    DocumentSnapshot snapShot = await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .get();
    if (snapShot == null) {
      callContext.setError('Vehicle not found');
      return callContext;
    }
    await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .update(ModelVehicle.getDocOf(vehicle))
        .then((value) => callContext.setSuccess('Vehicle Updated'))
        .catchError(
            (error) => callContext.setError('Error Updating Vehicle $error'));

    return callContext;
  }

  Future<List<ModelVehicle>> _getVehiclesForUser(ModelUser user) async {
    if (user.companyId == null || user.phoneNumber == null) {
      print('companyId or phoneNumber is null');
      return null;
    }
    QuerySnapshot snapShot;
    if (user.roleName == Constants.ADMIN) {
      snapShot = await fireStore
          .collection(Constants.VEHICLES)
          .where('CompanyId', isEqualTo: user.companyId)
          .get();
    } else {
      snapShot = await fireStore
          .collection(Constants.VEHICLES)
          .where('CompanyId', isEqualTo: user.companyId)
          .where('AllowedDrivers', arrayContains: user.phoneNumber)
          .get();
    }

    if (snapShot == null) {
      print("No Vehicles Found");
      return null;
    }
    return ModelVehicle.getVehicleFrom(snapShot);
  }

  void getVehicleList(AppData appData) async {
    List<ModelVehicle> vehiclesData = await _getVehiclesForUser(appData.user);
    if (vehiclesData != null && vehiclesData.isNotEmpty) {
      appData.setAvailableVehicles(vehiclesData);
    }
  }

  Future<CallContext> getVehicleByRegNo(String regNo) async {
    DocumentSnapshot doc =
        await fireStore.collection(Constants.VEHICLES).doc(regNo).get();
    if (doc == null) {
      callContext.setError('Vehicle not found');
      return callContext;
    }
    callContext.data = ModelVehicle.getVehicleFromDoc(doc);
    return callContext;
  }
}
