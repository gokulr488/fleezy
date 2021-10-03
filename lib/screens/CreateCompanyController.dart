import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataAccess/UserManagement.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCompanyController {
  Stream<User> userStream;
  StreamSubscription<User> userSubscription;

  Stream<String> messages;
  StreamController<String> messageStream = StreamController<String>();

  Authentication auth = Authentication();
  ModelCompany company = ModelCompany();

  String phoneNo;
  String otp;
  bool showSpinner = false;
  bool verified = false;
  bool disableButton = false;
  bool allowCompanyRegistration = false;

  void initListener() {
    userStream = FirebaseAuth.instance.authStateChanges();
    messages = messageStream.stream;
  }

  Future<void> onVerificationCompleted(BuildContext context) async {
    messageStream.add('Creating Your Company...');
    disableButton = true;
    final CallContext callContext =
        await UserManagement().addNewCompany(company);
    if (callContext.isError) {
      messageStream.add(callContext.errorMessage);
      return;
    }
    final AppData appData = Provider.of<AppData>(context, listen: false);
    final ModelUser adminUser = company.users[company.phoneNumber];
    appData.setUser(adminUser);
    appData.addNewDriver(adminUser);
    Provider.of<UiState>(context, listen: false).setIsAdmin(isAdmin: true);
    Navigator.popUntil(context, ModalRoute.withName(StartScreen.id));
    await Navigator.pushReplacementNamed(context, HomeScreen.id);
    await messageStream.close();
  }

  bool isValid() {
    if (disableButton) {
      return false;
    }
    if (company.companyName == null ||
        company.companyEmail == null ||
        company.phoneNumber == null) {
      if (verified) {
        if (otp == null) {
          messageStream.add('OTP is blank');
          return false;
        }
      }
      messageStream.add('Some fields are left empty');
      return false;
    }
    return true;
  }

  Future<void> onButtonPressed(BuildContext context) async {
    if (isValid()) {
      FocusScope.of(context).requestFocus(FocusNode());
      showSpinner = true;
      disableButton = true;
      messageStream.add('');
      try {
        verified ? await login(context) : verify(context);
      } catch (e) {
        showErrorAlert(context, 'Unable To Create Company');
        messageStream.add('Unable To Create Company');
        debugPrint(e.toString());
      }
      showSpinner = false;
      disableButton = false;
    }
  }

  Future<void> verify(BuildContext context) async {
    final ModelUser user = await Roles().getUser(company.phoneNumber);
    if (user != null) {
      showErrorAlert(context, 'Phone Number Already Exists');
      messageStream.add('Phone Number Already Exists');
      return;
    }
    auth.verifyPhone(company.phoneNumber);
    verified = true;
    messageStream.add('Verifying, Enter you OTP');
  }

  Future<void> login(BuildContext context) async {
    messageStream.add('Signing Up...');
    await auth.signInWithOTP(otp);
    await onVerificationCompleted(context);
  }

  void dispose() {
    userSubscription.cancel();
  }
}
