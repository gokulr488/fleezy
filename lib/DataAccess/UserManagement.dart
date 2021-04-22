import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataAccess/DAOs/Company.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelUser.dart';

class UserManagement {
  CallContext callContext;
  User user;
  UserManagement() {
    callContext = CallContext();
  }

  Future<CallContext> addNewCompany(ModelCompany modelCompany) async {
    try {
      user = Authentication().getUser();
      if (user != null) {
        print('Adding Company to Database with default Admin user');
        ModelUser adminUser = ModelUser(
            fullName: Constants.ADMIN,
            companyId: modelCompany.companyEmail,
            phoneNumber: modelCompany.phoneNumber,
            userEmailId: modelCompany.companyEmail,
            roleName: Constants.ADMIN,
            state: Constants.ACTIVE,
            uid: user.uid);
        modelCompany.users = {adminUser.phoneNumber: adminUser};
        await Company().addCompany(modelCompany);

        callContext.setSuccess('Company & Admin user added to DB');
      }
      return callContext;
    } catch (e) {
      callContext.setError('Unable to Create Company');
      await Authentication().deleteUser();
      print(e);
      return callContext;
    }
  }

  Future<CallContext> addUserToCompany(ModelUser user) async {
    return null;
  }
}
