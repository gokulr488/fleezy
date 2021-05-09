import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';

class Company {
  FirebaseFirestore fireStore;
  CallContext callContext;

  Company() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  Future<void> addCompany(ModelCompany company) async {
    final DocumentSnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .get();
    if (snapShot.data() != null) {
      print(snapShot.data().values);
      print("Company already exists");
      return;
    }

    await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .set(ModelCompany.getDocOf(company))
        .then((value) => print("Company Added"))
        .catchError((error) {
      print("Failed to add company: $error");
      return;
    });
    await Roles().addRole(company.users.values.first);
    return;
  }

  void updateCompany(ModelCompany company) async {
    final DocumentSnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .get();
    if (snapShot.data() == null) {
      print("Company not found");
      return;
    }

    return fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .update({
          'CompanyName': company.companyName,
          'CompanyEmail': company.companyEmail,
          'PhoneNumber': company.phoneNumber,
        })
        .then((value) => print("Company details updated"))
        .catchError((error) => print("Failed to update company: $error"));
  }
}
