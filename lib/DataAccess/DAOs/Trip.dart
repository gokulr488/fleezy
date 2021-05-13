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

  void updateTrip(ModelTrip trip, String companyId, String docid) async {
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(docid)
        .update(ModelTrip.getDocOf(trip))
        .then((value) => print("trip details updated"))
        .catchError((error) => print("Failed to update trip: $error"));
  }

  Future<void> deleteTrip(String companyId, String docid) async {
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(docid)
        .delete();
  }
}
