import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController {
  Stream<User> userStream;
  StreamSubscription<User> userSubscription;

  Stream<String> messages;
  StreamController<String> streamCtrl = StreamController<String>();

  Authentication auth = Authentication();
  ModelUser user = ModelUser();
  String phoneNo;
  String otp;
  bool showSpinner = false;
  bool verified = false;
  bool disableButton = false;

  void initListener() {
    userStream = FirebaseAuth.instance.authStateChanges();
    messages = streamCtrl.stream;
  }

  Future<void> onVerificationCompleted(BuildContext context) async {
    Provider.of<AppData>(context, listen: false).setUser(user);
    if (user.uid == null) {
      user.uid = Authentication().getUser()?.uid;
      await Roles().updateRole(user);
    }
    if (user.roleName != Constants.ADMIN) {
      Provider.of<UiState>(context, listen: false).setIsAdmin(false);
    }
    Navigator.popUntil(context, ModalRoute.withName(StartScreen.id));
    await Navigator.pushReplacementNamed(context, HomeScreen.id);
    await streamCtrl.close();
  }

  Future<void> onButtonPressed(BuildContext context) async {
    if (disableButton) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    if (phoneNo == null || phoneNo.length != 13) {
      showErrorAlert(context, 'Invalid Phone Number');
      return;
    }
    try {
      verified ? await login() : await verify();
    } catch (e) {
      showErrorAlert(context, 'Error Logging In');
    }
  }

  Future<void> login() async {
    streamCtrl.add('Logging In...');
    await auth.signInWithOTP(otp);
  }

  Future<void> verify() async {
    streamCtrl.add('Gathering Account Info...');
    user = await Roles().verifyUser(phoneNo);
    if (user == null) {
      streamCtrl.add('This Phone Number is not Registered');
      return;
    } else if (user.state != Constants.ACTIVE) {
      streamCtrl.add('This Phone Number is in ${user.state} state');
      return;
    }
    auth.verifyPhone(phoneNo);
    streamCtrl.add('Verifying, Enter your OTP');
    verified = true;
  }
}
