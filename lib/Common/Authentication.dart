import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/DataModels/ModelUser.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;
  String phoneNo, verificationId, smsCode;

  User getUser() {
    try {
      if (_auth.currentUser != null) {
        return _auth.currentUser;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  bool isLoggedIn() {
    try {
      if (_auth.currentUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteUser() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser.delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

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

  Future<bool> logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
        print('Signed Out');
        return true;
      }
      return false;
    } catch (e) {
      print('Unable to Sign Out');
      print(e);
      return false;
    }
  }

  _signIn(AuthCredential authCreds) async {
    try {
      await _auth.signInWithCredential(authCreds);
    } catch (e) {
      print('Unable To Sign In');
      print(e);
      return false;
    }
  }

  Future<void> signInWithOTP(smsCode) async {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _signIn(authCreds);
  }

  void verifyPhone(String phoneNo) {
    phoneNo = '+91' + phoneNo;
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      _signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      print(verId);
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
