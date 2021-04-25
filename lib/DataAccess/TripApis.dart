import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class TripApis {
  FirebaseFirestore fireStore;
  CallContext callContext;
  TripApis() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  Future<CallContext> startNewTrip(
      ModelTrip trip, ModelVehicle vehicle, BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    WriteBatch batch = fireStore.batch();
    DocumentReference tripRef = fireStore
        .collection(Constants.COMPANIES)
        .doc(user.companyId)
        .collection(Constants.TRIP)
        .doc();
    trip.id = tripRef.id;
    batch.set(tripRef, ModelTrip.getDocOf(trip));

    DocumentReference vehicleRef =
        fireStore.collection(Constants.VEHICLES).doc(vehicle.registrationNo);
    vehicle.isInTrip = true;
    vehicle.latestOdometerReading = trip.startReading;
    vehicle.currentDriver = user.fullName ?? user.phoneNumber;
    batch.update(vehicleRef, ModelVehicle.getDocOf(vehicle));

    DocumentReference driverRef =
        fireStore.collection(Constants.USERS).doc(user.phoneNumber);
    user.tripId = tripRef.id;
    batch.update(driverRef, ModelUser.getDocOf(user));

    batch.commit();
    if (callContext.isError) {
      return callContext;
    }
    return callContext;
  }

  Future<CallContext> endTrip(ModelTrip trip, BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    try {
      WriteBatch batch = fireStore.batch();

      DocumentReference tripRef = fireStore
          .collection(Constants.COMPANIES)
          .doc(user.companyId)
          .collection(Constants.TRIP)
          .doc(trip.id);
      batch.update(tripRef, ModelTrip.getDocOf(trip));

      DocumentReference vehicleRef =
          fireStore.collection(Constants.VEHICLES).doc(trip.vehicleRegNo);
      ModelVehicle vehicle =
          ModelVehicle.getVehicleFromDoc(await vehicleRef.get());
      vehicle.isInTrip = false;
      vehicle.latestOdometerReading = trip.endReading;
      batch.update(vehicleRef, ModelVehicle.getDocOf(vehicle));

      DocumentReference driverRef =
          fireStore.collection(Constants.USERS).doc(user.phoneNumber);
      user.tripId = null;
      batch.update(driverRef, ModelUser.getDocOf(user));

      batch.commit();
      callContext.setSuccess('Trip Ended');
      return callContext;
    } catch (e) {
      callContext.setError(e);
      return callContext;
    }
  }

  Future<ModelTrip> getTripById(String id, String companyId) async {
    DocumentSnapshot tripDoc = await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(id)
        .get();
    return ModelTrip.getTripFromDoc(tripDoc);
  }
}
