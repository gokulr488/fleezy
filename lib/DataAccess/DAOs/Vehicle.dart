// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';

class Vehicle {
  Vehicle() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }
  FirebaseFirestore fireStore;
  CallContext callContext;

  Future<CallContext> addVehicle(ModelVehicle vehicle) async {
    if (vehicle.companyId == null) {
      callContext.setError('companyId is null for the vehicle');
      return callContext;
    }
    final DocumentSnapshot<Map<String, dynamic>> docSnap = await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .get();
    if (docSnap.exists) {
      callContext.setError('Vehicle already exists');
      return callContext;
    }

    await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .set(vehicle.toJson())
        .then((dynamic value) => callContext.setSuccess('Vehicle added'))
        .catchError((dynamic error) => callContext.setError('$error'));

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
    await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .update(vehicle.toJson())
        .then((dynamic value) => callContext.setSuccess('Vehicle Updated'))
        .catchError((dynamic error) =>
            callContext.setError('Error Updating Vehicle $error'));

    return callContext;
  }

  Future<List<ModelVehicle>> _getVehiclesForUser(AppData appData) async {
    ModelUser user = appData.user;
    ModelCompany selectedCompany = appData.selectedCompany;
    if (selectedCompany?.companyEmail == null || user.phoneNumber == null) {
      print('companyId or phoneNumber is null');
      return null;
    }
    QuerySnapshot<Map<String, dynamic>> snapShot;
    if (user.roleName == Constants.ADMIN) {
      snapShot = await fireStore
          .collection(Constants.VEHICLES)
          .where('CompanyId', isEqualTo: selectedCompany.companyEmail)
          .get();
    } else {
      snapShot = await fireStore
          .collection(Constants.VEHICLES)
          .where('CompanyId', isEqualTo: selectedCompany.companyEmail)
          .where('AllowedDrivers', arrayContains: user.phoneNumber)
          .get();
    }

    if (snapShot == null) {
      print('No Vehicles Found');
      return null;
    }
    return ModelVehicle.fromDocs(snapShot);
  }

  Future<void> getVehicleList(AppData appData) async {
    final List<ModelVehicle> vehiclesData = await _getVehiclesForUser(appData);
    if (vehiclesData != null && vehiclesData.isNotEmpty) {
      appData.setAvailableVehicles(vehiclesData);
    }
  }

  Future<CallContext> getVehicleByRegNo(String regNo) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await fireStore.collection(Constants.VEHICLES).doc(regNo).get();
    if (!doc.exists) {
      callContext.setError('Vehicle not found');
      return callContext;
    }
    callContext.data = ModelVehicle.fromDoc(doc);
    return callContext;
  }
}
