// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';

class Company {
  Company() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }
  FirebaseFirestore fireStore;
  CallContext callContext;

  Future<CallContext> addCompany(ModelCompany company) async {
    final DocumentSnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .get();
    if (snapShot.exists) {
      callContext.setError('Company already exists');
      return callContext;
    }

    await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .set(ModelCompany.getDocOf(company))
        .then((dynamic value) => print('Company Added'))
        .catchError((dynamic error) {
      callContext.setError('Failed to add company: $error');
      return callContext;
    });
    return Roles().addRole(company.users.values.first);
  }

  Future<void> updateCompany(ModelCompany company) async {
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .update(<String, String>{
          'CompanyName': company.companyName,
          'CompanyEmail': company.companyEmail,
          'PhoneNumber': company.phoneNumber,
        })
        .then((dynamic value) => print('Company details updated'))
        .catchError(
            (dynamic error) => print('Failed to update company: $error'));
  }
}
