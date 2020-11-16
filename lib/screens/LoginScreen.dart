import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

const TextStyle kMessagesTextStyle = TextStyle(fontSize: 15);

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authentication auth = Authentication();
  ModelUser user = ModelUser();
  String phoneNo;
  String otp;
  bool showSpinner = false;
  bool verified = false;
  bool disableButton = false;
  String message = '';
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) async {
      if (user == null) {
        print('Login Screen :User is currently signed out!');
      } else {
        if (verified) {
          setState(() {
            verified = false; //to avoid multiple entry into this code
            showSpinner = true;
            disableButton = true;
          });
          await onVerificationCompleted();
          print('Login Screen :User signed in!');
        }
      }
    });

    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Fleezy', style: kFleezyTextStyle),
          Visibility(visible: showSpinner, child: LoadingDots(size: 50)),
          Text(message, style: kMessagesTextStyle),
          TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                phoneNo = '+91' + value; //TODO change this impl
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Phone Number')),
          Visibility(
              visible: verified,
              child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    otp = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter the OTP'))),
          RoundedButton(
            title: verified ? 'Log In' : 'Send OTP',
            colour: kHighlightColour,
            onPressed: () async {
              onButtonPressed();
            },
          ),
        ],
      ),
    );
  }

  Future<void> onButtonPressed() async {
    if (disableButton) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    if (phoneNo == null || phoneNo.length != 10) {
      setState(() {
        message = 'Invalid Phone Number';
      });
      print('Phone Number is not Valid');
      return;
    }
    setState(() {
      showSpinner = true;
      disableButton = true;
    });
    verified ? await login() : await verify();
    setState(() {
      showSpinner = false;
      disableButton = false;
    });
  }

  onVerificationCompleted() {
    Navigator.pushNamed(context, HomeScreen.id, arguments: user);
  }

  Future<void> login() async {
    setState(() {
      message = 'Signing In...';
    });
    await auth.signInWithOTP(otp);
    //await onVerificationCompleted();
  }

  Future<void> verify() async {
    setState(() {
      message = 'Gathering Account Info...';
    });
    user = await Roles().verifyUser(phoneNo);
    if (user == null) {
      setState(() {
        message = 'This Phone Number is not Registered';
      });
      return;
    } else if (user.state != Constants.ACTIVE) {
      setState(() {
        message = 'This Phone Number is in ${user.state} state';
      });
      return;
    }
    auth.verifyPhone(phoneNo);
    setState(() {
      message = 'Verifying, Enter your OTP';
      verified = true;
    });
  }
}
