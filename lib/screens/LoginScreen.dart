import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/UiConstants.dart';
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
            Text('Fleezy', style: kFleezyTextStyle),
            Visibility(visible: showSpinner, child: LoadingDots(size: 50)),
            Text(message, style: kMessagesTextStyle),
            TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  phoneNo = value;
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
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter the OTP'),
              ),
            ),
            RoundedButton(
              title: verified ? 'Log In' : 'Send OTP',
              colour: Colors.blue,
              onPressed: disableButton
                  ? null
                  : () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (phoneNo == null) {
                        print('Phone Number is not Valid');
                        return;
                      }
                      setState(() {
                        showSpinner = true;
                      });
                      verified ? await login() : await verify();
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

  onVerificationCompleted() {}

  login() {}

  verify() {}
}
