import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';

class Company {
  FirebaseFirestore fireStore;

  Company() {
    fireStore = FirebaseFirestore.instance;
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

    fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .set({
          'CompanyName': company.companyName,
          'CompanyEmail': company.companyEmail,
          'PhoneNumber': company.phoneNumber
        })
        .then((value) => print("Company Added"))
        .catchError((error) => print("Failed to add company: $error"));
    Roles().addRole(company.users.first, company.companyEmail);
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

  Future<ModelCompany> getCompany(String docId) async {
    final DocumentSnapshot snapShot =
        await fireStore.collection(Constants.COMPANIES).doc(docId).get();
    if (snapShot.data() == null) {
      print("Company not found");
      return null;
    }

    ModelCompany result = ModelCompany(
        companyName: snapShot['CompanyName'],
        companyEmail: snapShot['CompanyEmail'],
        phoneNumber: snapShot['PhoneNumber']);
    return result;
  }
}
