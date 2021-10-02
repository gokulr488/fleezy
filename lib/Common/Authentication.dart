// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneNo;
  String verificationId;
  String smsCode;

  User getUser() {
    try {
      if (_auth.currentUser != null) {
        return _auth.currentUser;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  bool isLoggedIn() {
    try {
      if (_auth.currentUser != null) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint(e.toString());
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.signOut();
        debugPrint('Signed Out');
        return true;
      }
    } catch (e) {
      debugPrint('Unable to Sign Out. $e');
    }
    return false;
  }

  Future<bool> _signIn(AuthCredential authCreds) async {
    try {
      await _auth.signInWithCredential(authCreds);
      return true;
    } catch (e) {
      debugPrint('Unable To Sign In. $e');
    }
    return false;
  }

  Future<void> signInWithOTP(String smsCode) async {
    final AuthCredential authCreds = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _signIn(authCreds);
  }

  void verifyPhone(String phoneNo) {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      _signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      debugPrint(authException.message);
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      verificationId = verId;
      debugPrint(verId);
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
