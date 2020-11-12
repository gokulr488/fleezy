import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Company.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

const TextStyle kFleezyTextStyle =
    TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
const TextStyle kMessagesTextStyle = TextStyle(fontSize: 15);

class CreateCompanyScreen extends StatefulWidget {
  static const String id = 'createCompanyScreen';
  @override
  _CreateCompanyScreenState createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  String companyName;
  String emailId;
  String phoneNumber;
  String otp;
  bool showSpinner = false;
  bool verified = false;
  bool disableButton = false;
  String messages = '';
  Authentication auth = Authentication();
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user == null) {
        print('Create Company Screen: User is currently signed out!');
      } else {
        if (verified) {
          setState(() {
            verified = false; //to avoid multiple entry into this code
            showSpinner = true;
            disableButton = true;
          });
          await onVerificationCompleted();
          Navigator.pushNamed(context, HomeScreen.id);
        }
        print('User signed in!');
      }
    });

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Fleezy',
              style: kFleezyTextStyle,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                companyName = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Company Name'),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                emailId = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email ID'),
            ),
            TextField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Phone number'),
            ),
            Visibility(
              visible: verified,
              child: TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  otp = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'OTP'),
              ),
            ),
            Visibility(visible: showSpinner, child: LoadingDots(size: 40)),
            Text(
              messages,
              style: kMessagesTextStyle,
            ),
            RoundedButton(
              title: verified ? 'Login' : 'Send OTP',
              colour: Colors.blue,
              onPressed: disableButton
                  ? null
                  : () async {
                      if (companyName == null ||
                          emailId == null ||
                          phoneNumber == null) {
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
                      });
                      verified ? await login() : verify();

                      setState(() {
                        showSpinner = false;
                      });
                    },
            ),
          ],
        ),
      )),
    );
  }

  void verify() {
    setState(() {
      messages = 'Verifying, Enter you OTP';
      disableButton = true;
    });
    auth.verifyPhone(phoneNumber);
    setState(() {
      verified = true;
      disableButton = false;
    });
  }

  Future<void> login() async {
    setState(() {
      messages = 'Signing Up...';
      disableButton = true;
      showSpinner = true;
    });
    await auth.signInWithOTP(otp);
    await onVerificationCompleted();
    setState(() {
      showSpinner = false;
    });
  }

  Future<void> onVerificationCompleted() async {
    setState(() {
      messages = 'Creating Your Company...';
    });
    disableButton = true;
    ModelUser user = ModelUser(
        companyId: emailId,
        phoneNumber: phoneNumber,
        userEmailId: emailId,
        roleName: Constants.ADMIN,
        state: Constants.ACTIVE,
        uid: auth.getUser().uid);
    ModelCompany modelCompany = ModelCompany(
        companyEmail: emailId,
        phoneNumber: phoneNumber,
        companyName: companyName);
    modelCompany.users = {user.uid: user};
    print('adding Company');
    await Company().addCompany(modelCompany);
  }
}
