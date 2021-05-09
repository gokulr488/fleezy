import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';
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
    trip.status = Constants.STARTED;
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

    await batch
        .commit()
        .then((value) => callContext.setSuccess('Trip STarted'))
        .catchError((error) => callContext.setError("$error"));
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
      trip.status = Constants.ENDED;
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

      await batch.commit();
      callContext.setSuccess('Trip Ended');
      return callContext;
    } catch (e) {
      callContext.setError(e.toString());
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

  Future<CallContext> cancelTrip(ModelTrip trip, BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    try {
      WriteBatch batch = fireStore.batch();

      DocumentReference tripRef = fireStore
          .collection(Constants.COMPANIES)
          .doc(user.companyId)
          .collection(Constants.TRIP)
          .doc(trip.id);
      trip.status = Constants.CANCELLED;
      trip.endDate = Timestamp.now();
      batch.update(tripRef, ModelTrip.getDocOf(trip));

      DocumentReference vehicleRef =
          fireStore.collection(Constants.VEHICLES).doc(trip.vehicleRegNo);
      ModelVehicle vehicle =
          ModelVehicle.getVehicleFromDoc(await vehicleRef.get());
      vehicle.isInTrip = false;
      batch.update(vehicleRef, ModelVehicle.getDocOf(vehicle));

      DocumentReference driverRef =
          fireStore.collection(Constants.USERS).doc(user.phoneNumber);
      user.tripId = null;
      batch.update(driverRef, ModelUser.getDocOf(user));

      await batch.commit();
      callContext.setSuccess('Trip Cancelled');
      return callContext;
    } catch (e) {
      callContext.setError(e.toString());
      return callContext;
    }
  }

  Future<CallContext> getAllTripsOf(String regNo, BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    QuerySnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(user.companyId)
        .collection(Constants.TRIP)
        .where('VehicleRegNo', isEqualTo: regNo)
        .get();
    //TODO paginate this API
    callContext.data = ModelTrip.getTripsFrom(snapShot);
    return callContext;
  }
}
