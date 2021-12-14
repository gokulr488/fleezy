// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelUser.dart';

class Roles {
  Roles() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }
  FirebaseFirestore fireStore;
  CallContext callContext;

  Future<CallContext> addRole(ModelUser user) async {
    final DocumentSnapshot<Map<String, dynamic>> snapShot =
        await fireStore.collection(Constants.USERS).doc(user.phoneNumber).get();
    if (snapShot.exists) {
      callContext.setError('User already exists');
      return callContext;
    }
    await fireStore
        .collection(Constants.USERS)
        .doc(user.phoneNumber)
        .set(user.toJson())
        .then((dynamic value) => callContext
            .setSuccess('User Added')) // check this if unknown error is thrown
        .catchError((dynamic error) =>
            callContext.setError('Error Adding User $error'));
    return callContext;
  }

  Future<CallContext> updateRole(ModelUser user) async {
    await fireStore
        .collection(Constants.USERS)
        .doc(user.phoneNumber)
        .update(user.toJson())
        .then((dynamic value) => callContext.setSuccess('User updated'))
        .catchError((dynamic error) =>
            callContext.setError('Error Updating User $error'));
    return callContext;
  }

  Future<void> deleteUser(String docid) async {
    await fireStore.collection(Constants.USERS).doc(docid).delete();
  }

  Future<ModelUser> verifyUser(String phoneNumber) async {
    return getUser(phoneNumber);
  }

  Future<ModelUser> getUser(String phoneNumber) async {
    final DocumentSnapshot<ModelUser> snapShot = await fireStore
        .collection(Constants.USERS)
        .doc(phoneNumber)
        .withConverter<ModelUser>(
            fromFirestore: (snapshots, _) =>
                ModelUser.fromJson(snapshots.data()),
            toFirestore: (modelUser, _) => modelUser.toJson())
        .get();
    if (!snapShot.exists) return null;
    return snapShot.data();
  }

  Future<List<ModelUser>> getAllUsersInCompany(String companyId) async {
    final QuerySnapshot snapshot = await fireStore
        .collection(Constants.USERS)
        .where('CompanyId', arrayContains: companyId)
        .get();

    return ModelUser.getUsersFrom(snapshot);
  }
}
