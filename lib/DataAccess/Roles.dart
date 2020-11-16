import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelUser.dart';

class Roles {
  FirebaseFirestore fireStore;
  CallContext callContext;

  Roles() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  Future<void> addRole(ModelUser user) async {
    DocumentSnapshot snapShot =
        await fireStore.collection(Constants.USERS).doc(user.phoneNumber).get();
    if (snapShot.data() != null) {
      print("User already exists");
      return;
    }
    fireStore
        .collection(Constants.USERS)
        .doc(user.phoneNumber)
        .set(ModelUser.getDocOf(user))
        .then(callContext.setSuccess('User added'))
        .catchError((error) => callContext.setError("$error"));
    if (callContext.isError) {
      print(callContext.errorMessage);
      return;
    }
    return;
  }

  void updateRole(ModelUser user) async {
    final DocumentSnapshot snapShot =
        await fireStore.collection(Constants.USERS).doc(user.userEmailId).get();
    if (snapShot.data() == null) {
      print("User not found");
      return;
    }

    return fireStore
        .collection(Constants.USERS)
        .doc(user.userEmailId)
        .update(ModelUser.getDocOf(user))
        .then((value) => print("User details updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deleteUser(String docid) async {
    DocumentSnapshot snapShot =
        await fireStore.collection(Constants.USERS).doc(docid).get();
    if (snapShot.data() == null) {
      print("User not found");
      return null;
    }

    fireStore.collection(Constants.USERS).doc(docid).delete();
  }

  Future<ModelUser> verifyUser(String phoneNumber) async {
    return getUser(phoneNumber);
  }

  Future<ModelUser> getUser(String phoneNumber) async {
    QuerySnapshot snapshot = await fireStore
        .collection(Constants.USERS)
        .where('PhoneNumber', isEqualTo: phoneNumber)
        .get();

    return ModelUser.getUserFromSnapshot(snapshot);
  }
}
