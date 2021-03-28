import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

class Trip {
  FirebaseFirestore fireStore;
  CallContext callContext;

  Trip() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  void addTrip(ModelTrip trip, String companyId) async {
    fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .add({
          'StartDate': trip.startDate,
          'EndDate': trip.endDate,
          'Timestamp': trip.timestamp,
          'StartReading': trip.startReading,
          'EndReading': trip.endReading,
          'Distance': trip.distance,
          'BillAmount': trip.billAmount,
          'PaidAmount': trip.paidAmount,
          'BalanceAmount': trip.balanceAmount,
          'DriverSalary': trip.driverSalary,
          'CustomerName': trip.customerName,
          'TripNo': trip.tripNo,
          'VehicleRegNo': trip.vehicleRegNo
        })
        .then((value) => callContext.setSuccess('trip added'))
        .catchError((error) => callContext.setError("$error"));

    if (callContext.isError) {
      print(callContext.errorMessage);
      return null;
    } else
      print(callContext.message);
  }

  void updateTrip(ModelTrip trip, String companyId, String docid) async {
    final DocumentSnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid)
        .get();
    if (snapShot.data() == null) {
      print("User not found");
      return;
    }

    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(docid)
        .update({
          'StartDate': trip.startDate,
          'EndDate': trip.endDate,
          'Timestamp': trip.timestamp,
          'StartReading': trip.startReading,
          'EndReading': trip.endReading,
          'Distance': trip.distance,
          'BillAmount': trip.billAmount,
          'PaidAmount': trip.paidAmount,
          'BalanceAmount': trip.balanceAmount,
          'DriverSalary': trip.driverSalary,
          'CustomerName': trip.customerName,
          'TripNo': trip.tripNo,
          'VehicleRegNo': trip.vehicleRegNo
        })
        .then((value) => print("trip details updated"))
        .catchError((error) => print("Failed to update trip: $error"));
  }

  Future<void> deleteTrip(String companyId, String docid) async {
    DocumentSnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(docid)
        .get();
    if (snapShot.data() == null) {
      print("Trip not found");
      return null;
    }
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(docid)
        .delete();
  }
}
