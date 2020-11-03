import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataAccess/Company.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelUser.dart';

class UserManagement {
  User user;
  Future<void> addNewCompany(ModelCompany modelCompany) async {
    try {
      user = Authentication().getUser();
      if (user != null) {
        print('Adding Company to Database with default Admin user');
        ModelUser adminUser = ModelUser(
            fullName: 'Admin',
            roleName: Constants.ADMIN,
            uid: user.uid,
            userEmailId: modelCompany.companyEmail,
            companyId: modelCompany.companyEmail);
        modelCompany.users = {adminUser.uid: adminUser};
        await Company().addCompany(modelCompany);
        print('Company & Admin user added to DB');
      }
      return;
    } catch (e) {
      print('Deleting User ${user.email}');
      await Authentication().deleteUser();
      print(e);
      return;
    }
  }
}
