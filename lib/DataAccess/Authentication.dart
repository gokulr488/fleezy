import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataAccess/Company.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelUser.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;
  String phoneNo, verificationId, smsCode;
  Future<void> addNewCompany(ModelCompany modelCompany) async {
    UserCredential userCredential;
    try {
      // userCredential = await _auth.createUserWithEmailAndPassword(
      //     email: modelCompany.companyEmail, password: modelCompany.password);
      verifyPhone(modelCompany.phoneNumber);
    } catch (e) {
      print('Unable to create New Company');
      print(e);
      return;
    }
    try {
      if (userCredential != null) {
        print('Company Created. Adding to Database with default Admin user');
        ModelUser adminUser = ModelUser(
            fullName: 'Admin',
            roleName: Constants.ADMIN,
            uid: userCredential.user.uid,
            userEmailId: modelCompany.companyEmail,
            companyId: modelCompany.companyEmail);
        modelCompany.users = {adminUser.uid: adminUser};
        await Company().addCompany(modelCompany);
        print('Company & Admin user added to DB');
      }
      return;
    } catch (e) {
      print('Deleting User ${_auth.currentUser.email}');
      await _auth.currentUser.delete();
      print(e);
      return;
    }
  }

  void addNewUser() {}

  Future<bool> login(ModelUser user) async {
    try {
      if (user != null && user.password != null && user.userEmailId != null) {
        await _auth.signInWithEmailAndPassword(
            email: user.userEmailId, password: user.password);
        if (_auth.currentUser != null) {
          print('Sign In Successful');
          return true;
        }
        return false;
      } else {
        print('Email ID or password is null');
        return false;
      }
    } catch (e) {
      print('Unable To Sign In');
      print(e);
      return false;
    }
  }

  void logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
        print('Signed Out');
      }
    } catch (e) {
      print('Unable to Sign Out');
      print(e);
    }
  }

  //Handles Auth
  // handleAuth() {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges,
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return DashboardPage();
  //         } else {
  //           return LoginPage();
  //         }
  //       });
  // }

  //SignIn
  signIn(AuthCredential authCreds) {
    _auth.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
