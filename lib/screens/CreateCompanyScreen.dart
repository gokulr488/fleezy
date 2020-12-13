import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Company.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

const TextStyle kFleezyTextStyle = TextStyle(
    fontSize: 55,
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.bold,
    color: kHighlightColour);
const TextStyle _kMessagesTextStyle = TextStyle(fontSize: 15);

class CreateCompanyScreen extends StatefulWidget {
  static const String id = 'createCompanyScreen';
  @override
  _CreateCompanyScreenState createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  ModelCompany company = ModelCompany();
  String otp;
  bool showSpinner = false;
  bool verified = false;
  bool disableButton = false;
  bool allowCompanyRegistration = false;
  String messages = '';
  Authentication auth = Authentication();
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (allowCompanyRegistration) {
        allowCompanyRegistration = false;
        if (user == null) {
          print('Create Company Screen: User is currently signed out!');
        } else {
          setState(() {
            showSpinner = true;
            disableButton = true;
          });
          await onVerificationCompleted();
          print('User signed in!');
        }
      }
    });

    return BaseScreen(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text('FleeZy', style: kFleezyTextStyle),
      TextField(
          textAlign: TextAlign.center,
          onChanged: (value) {
            company.companyName = value;
          },
          decoration: kTextFieldDecoration.copyWith(hintText: 'Company Name')),
      TextField(
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.center,
          onChanged: (value) {
            company.companyEmail = value;
          },
          decoration: kTextFieldDecoration.copyWith(hintText: 'Email ID')),
      TextField(
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.center,
          onChanged: (value) {
            company.phoneNumber = '+91' + value; //TODO change this impl
          },
          decoration: kTextFieldDecoration.copyWith(hintText: 'Phone number')),
      Visibility(
          visible: verified,
          child: TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                otp = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'OTP'))),
      Visibility(visible: showSpinner, child: LoadingDots(size: 40)),
      Text(messages, style: _kMessagesTextStyle),
      RoundedButton(
          title: verified ? 'Login' : 'Send OTP',
          colour: kHighlightColour,
          onPressed: () async {
            await onButtonPressed();
          })
    ]));
  }

  Future<void> onButtonPressed() async {
    if (disableButton) {
      return;
    }
    if (company.companyName == null ||
        company.companyEmail == null ||
        company.phoneNumber == null) {
      if (verified) {
        if (otp == null) {
          print('OTP is blank');
          return;
        }
      }
      print('Some fields are left empty');
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      showSpinner = true;
      disableButton = true;
    });
    verified ? await login() : verify();
    setState(() {
      showSpinner = false;
      disableButton = false;
    });
  }

  void verify() {
    auth.verifyPhone(company.phoneNumber);
    setState(() {
      messages = 'Verifying, Enter you OTP';
      verified = true;
    });
  }

  Future<void> login() async {
    setState(() {
      messages = 'Signing Up...';
    });
    await auth.signInWithOTP(otp);
    await onVerificationCompleted();
  }

  Future<void> onVerificationCompleted() async {
    setState(() {
      messages = 'Creating Your Company...';
    });
    disableButton = true;
    ModelUser user = ModelUser(
        companyId: company.companyEmail,
        phoneNumber: company.phoneNumber,
        userEmailId: company.companyEmail,
        roleName: Constants.ADMIN,
        state: Constants.ACTIVE,
        uid: auth.getUser().uid);
    company.users = {user.uid: user};
    print('adding Company');
    await Company().addCompany(company);
    Navigator.pushNamed(context, HomeScreen.id, arguments: user);
  }
}
