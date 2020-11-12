import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';

class ModelCompany {
  String companyName;
  String companyEmail;
  String password;
  String phoneNumber;
  Map<String, ModelVehicle> vehicles;
  Map<String, ModelUser> users;
  Map<String, ModelExpense> expenses;
  Map<String, ModelTrip> trips;

  ModelCompany(
      {this.trips,
      this.users,
      this.expenses,
      this.companyName,
      this.companyEmail,
      this.password,
      this.phoneNumber,
      this.vehicles});

  static Map<String, dynamic> getDocOf(ModelCompany company) {
    return {
      'CompanyName': company.companyName,
      'CompanyEmail': company.companyEmail,
      'Password': company.password,
      'Vehicles': company.vehicles,
      'PhoneNumber': company.phoneNumber,
      'Users': company.users,
      'Expenses': company.expenses,
      'Trips': company.trips
    };
  }

  static ModelCompany getCompanyFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelCompany(
      companyName: data['CompanyName'] ?? '',
      companyEmail: data['CompanyEmail'] ?? '',
      password: data['Password'] ?? '',
      vehicles: data['Vehicles'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      users: data['Users'] ?? '',
      expenses: data['Expenses'] ?? '',
      trips: data['Trips'] ?? '',
    );
  }

  static List<ModelCompany> getCompanyFrom(QuerySnapshot snapshot) {
    List<ModelCompany> users = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      users.add(getCompanyFromDoc(doc));
    }
    return users;
  }

  static ModelCompany getUserFromSnapshot(QuerySnapshot snapshot) {
    QueryDocumentSnapshot doc = snapshot.docs.first;
    return getCompanyFromDoc(doc);
  }
}
