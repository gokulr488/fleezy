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
    batch.set(tripRef, ModelTrip.getDocOf(trip));

    DocumentReference vehicleRef =
        fireStore.collection(Constants.VEHICLES).doc(vehicle.registrationNo);
    vehicle.isInTrip = true;
    vehicle.currentDriver = user.fullName ?? user.phoneNumber;
    batch.update(vehicleRef, ModelVehicle.getDocOf(vehicle));

    DocumentReference driverRef =
        fireStore.collection(Constants.USERS).doc(user.phoneNumber);
    user.isInTrip = true;
    batch.update(driverRef, ModelUser.getDocOf(user));

    batch.commit();
    if (callContext.isError) {
      return callContext;
    }
    return callContext;
  }
  //TODO batch update for start new trip completed.
  //need to create screen where if user has started trip, should land only on trip progress
}
