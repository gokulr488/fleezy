import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

class Trip {
  Trip() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }
  FirebaseFirestore fireStore;
  CallContext callContext;

  Future<CallContext> updateTrip(ModelTrip trip, String companyId) async {
    await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(trip.id)
        .update(ModelTrip.getDocOf(trip))
        .then((dynamic value) => callContext.setSuccess('Trip updated'))
        .catchError((dynamic error) =>
            callContext.setError('Error Updating Trip ${error.toString()}'));
    return callContext;
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
