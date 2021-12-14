import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';

class ModelCompany {
  ModelCompany(
      {this.trip,
      this.users,
      this.expense,
      this.companyName,
      this.companyEmail,
      this.password,
      this.phoneNumber,
      this.vehicles});

  String companyName;
  String companyEmail;
  String password;
  String phoneNumber;
  Map<String, ModelVehicle> vehicles;
  Map<String, ModelUser> users;
  Map<String, ModelExpense> expense;
  Map<String, ModelTrip> trip;

  static Map<String, dynamic> getDocOf(ModelCompany company) {
    return <String, dynamic>{
      'CompanyName': company.companyName,
      'CompanyEmail': company.companyEmail,
      'Password': company.password,
      'Vehicles': company.vehicles,
      'PhoneNumber': company.phoneNumber,
      'Users': _getListOfUsers(company.users),
      'Expense': company.expense,
      'Trip': company.trip
    };
  }

  static List<String> _getListOfUsers(Map<String, ModelUser> users) {
    final List<String> userList = [];
    for (final ModelUser user in users.values) {
      userList.add(user.phoneNumber);
    }
    return userList;
  }

  static ModelCompany fromDoc(DocumentSnapshot<dynamic> doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return ModelCompany(
      companyName: (json['CompanyName'] ?? '') as String,
      companyEmail: (json['CompanyEmail'] ?? '') as String,
      password: (json['Password'] ?? '') as String,
      //vehicles: data['Vehicles'] ?? '',
      phoneNumber: (json['PhoneNumber'] ?? '') as String,
      //users: data['Users'] ?? '',
      //expense: data['Expense'] ?? '',
      //trip: data['Trip'] ?? '',
    );
  }

  static ModelCompany getCompanyFromDoc(DocumentSnapshot<dynamic> doc) {
    final Map<String, String> data = doc.data() as Map<String, String>;

    return ModelCompany(
      companyName: data['CompanyName'] ?? '',
      companyEmail: data['CompanyEmail'] ?? '',
      password: data['Password'] ?? '',
      //vehicles: data['Vehicles'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      //users: data['Users'] ?? '',
      //expense: data['Expense'] ?? '',
      //trip: data['Trip'] ?? '',
    );
  }

  static List<ModelCompany> getCompanyFrom(QuerySnapshot<String> snapshot) {
    final List<ModelCompany> users = [];
    for (final DocumentSnapshot<String> doc in snapshot.docs) {
      users.add(getCompanyFromDoc(doc));
    }
    return users;
  }

  static ModelCompany getUserFromSnapshot(QuerySnapshot<String> snapshot) {
    final DocumentSnapshot<String> doc = snapshot.docs.first;
    return getCompanyFromDoc(doc);
  }
}
