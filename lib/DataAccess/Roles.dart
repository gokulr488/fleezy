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

  Future<CallContext> addRole(ModelUser user) async {
    DocumentSnapshot snapShot =
        await fireStore.collection(Constants.USERS).doc(user.phoneNumber).get();
    if (snapShot.data() != null) {
      print('User already exists');
      callContext.setError('User already exists');
      return callContext;
    }
    fireStore
        .collection(Constants.USERS)
        .doc(user.phoneNumber)
        .set(ModelUser.getDocOf(user))
        .then(callContext.setSuccess('User added'))
        .catchError((error) => callContext.setError("$error"));
    if (callContext.isError) {
      print(callContext.errorMessage);
      return callContext;
    }
    return callContext;
  }

  Future<CallContext> updateRole(ModelUser user) async {
    final DocumentSnapshot snapShot =
        await fireStore.collection(Constants.USERS).doc(user.phoneNumber).get();
    if (snapShot.data() == null) {
      print("User not found");
      callContext.setError('User not found');
      return callContext;
    }

    await fireStore
        .collection(Constants.USERS)
        .doc(user.phoneNumber)
        .update(ModelUser.getDocOf(user))
        .then((value) {
      print("User details updated");
      callContext.setSuccess('User updated');
    }).catchError((error) {
      print("Error Updating User $error");
      callContext.setSuccess('Error Updating User $error');
    });
    return callContext;
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
    final DocumentSnapshot snapShot =
        await fireStore.collection(Constants.USERS).doc(phoneNumber).get();
    return ModelUser.getUserFromDoc(snapShot);
  }

  Future<List<ModelUser>> getAllUsersInCompany(String companyId) async {
    QuerySnapshot snapshot = await fireStore
        .collection(Constants.USERS)
        .where('CompanyId', isEqualTo: companyId)
        .get();

    return ModelUser.getUsersFrom(snapshot);
  }
}
