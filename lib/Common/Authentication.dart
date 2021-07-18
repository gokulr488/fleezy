import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;
  String phoneNo, verificationId, smsCode;

  User getUser() {
    try {
      if (_auth.currentUser != null) {
        return _auth.currentUser;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  bool isLoggedIn() {
    try {
      if (_auth.currentUser != null) {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> deleteUser() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser.delete();
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
        print('Signed Out');
        return true;
      }
    } catch (e) {
      print('Unable to Sign Out. $e');
    }
    return false;
  }

  Future<bool> _signIn(AuthCredential authCreds) async {
    try {
      await _auth.signInWithCredential(authCreds);
      return true;
    } catch (e) {
      print('Unable To Sign In. $e');
    }
    return false;
  }

  Future<void> signInWithOTP(String smsCode) async {
    AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _signIn(authCreds);
  }

  void verifyPhone(String phoneNo) {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      _signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationId = verId;
      print(verId);
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      verificationId = verId;
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
