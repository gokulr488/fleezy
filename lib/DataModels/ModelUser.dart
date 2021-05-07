import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
  String uid;
  String roleName; //Avaiable roles Driver,Admin
  String fullName;
  String userEmailId;
  String phoneNumber; // Never allow modification of Number
  String password;
  String companyId;
  String state;
  String tripId;
  ModelUser(
      {this.uid,
      this.roleName,
      this.fullName,
      this.userEmailId,
      this.phoneNumber,
      this.password,
      this.companyId,
      this.state,
      this.tripId});

  static Map<String, dynamic> getDocOf(ModelUser user) {
    return {
      'Uid': user.uid,
      'RoleName': user.roleName,
      'FullName': user.fullName,
      'EmailId': user.userEmailId,
      'PhoneNumber': user.phoneNumber,
      'CompanyId': user.companyId,
      'State': user.state,
      'TripId': user.tripId
    };
  }

  static ModelUser getUserFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelUser(
      uid: data['Uid'],
      roleName: data['RoleName'] ?? '',
      fullName: data['FullName'] ?? '',
      userEmailId: data['EmailId'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      companyId: data['CompanyId'] ?? '',
      state: data['State'] ?? '',
      tripId: data['TripId'],
    );
  }

  static List<ModelUser> getUsersFrom(QuerySnapshot snapshot) {
    List<ModelUser> users = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      users.add(getUserFromDoc(doc));
    }
    return users;
  }

  static ModelUser getUserFromSnapshot(QuerySnapshot snapshot) {
    if (snapshot.docs.isEmpty) {
      return null;
    }
    QueryDocumentSnapshot doc = snapshot.docs.first;
    return getUserFromDoc(doc);
  }
}
