import 'package:cloud_firestore/cloud_firestore.dart';

class ModelUser {
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

  ModelUser.fromJson(Map<String, Object> json)
      : this(
          uid: json['Uid'] as String,
          roleName: (json['RoleName'] ?? '') as String,
          fullName: (json['FullName'] ?? '') as String,
          userEmailId: (json['EmailId'] ?? '') as String,
          phoneNumber: (json['PhoneNumber'] ?? '') as String,
          companyId: List<String>.from(json['CompanyId'] as List<dynamic>),
          state: (json['State'] ?? '') as String,
          tripId: json['TripId'] as String,
        );

  String uid;
  String roleName; //Avaiable roles Driver,Admin
  String fullName;
  String userEmailId;
  String phoneNumber; // Never allow modification of Number
  String password;
  List<String> companyId;
  String state;
  String tripId;

  Map<String, Object> toJson() {
    return <String, Object>{
      'Uid': uid,
      'RoleName': roleName,
      'FullName': fullName,
      'EmailId': userEmailId,
      'PhoneNumber': phoneNumber,
      'CompanyId': companyId,
      'State': state,
      'TripId': tripId
    };
  }

  static List<ModelUser> getUsersFrom(QuerySnapshot snapshot) {
    final List<ModelUser> users = [];
    for (final QueryDocumentSnapshot doc in snapshot.docs) {
      users.add(ModelUser.fromJson(doc.data()));
    }
    return users;
  }
}
