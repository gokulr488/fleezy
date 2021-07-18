import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/AuthenticationController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextStyle kMessagesTextStyle = TextStyle(fontSize: 15);

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthenticationController ctrl = AuthenticationController();
  String message = '';

  @override
  void initState() {
    super.initState();
    ctrl.initListener();
    ctrl.userSubscription = ctrl.userStream.listen(onUserStreamEvent);
    ctrl.messages.listen(onMessage);
  }

  @override
  void dispose() {
    super.dispose();
    ctrl.userSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      headerText: '', //To Disable AppBar
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Fleezy',
              style: GoogleFonts.dancingScript(
                  color: kHighlightColour,
                  shadows: shadow,
                  fontWeight: FontWeight.bold,
                  fontSize: 60)),
          if (message == 'Logging In...') LoadingDots(size: 50),
          Text(message, style: kMessagesTextStyle),
          TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                ctrl.phoneNo = '+91$value'; //TODO change this impl
              },
              decoration:
                  kTextFieldDecoration.copyWith(labelText: 'Phone Number')),
          Visibility(
              visible: ctrl.verified,
              child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    ctrl.otp = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Enter the OTP'))),
          RoundedButton(
            title: ctrl.verified ? 'Log In' : 'Send OTP',
            onPressed: () async {
              await ctrl.onButtonPressed(context);
            },
          ),
        ],
      ),
    );
  }

  void onUserStreamEvent(User user) async {
    if (user == null) {
      print('Login Screen :User is currently signed out!');
    } else {
      if (ctrl.verified) {
        ctrl.verified = false; //to avoid multiple entry into this code
        ctrl.showSpinner = true;
        ctrl.disableButton = true;
        setState(() {});
        await ctrl.onVerificationCompleted(context);
        print('Login Screen :User signed in!');
      }
    }
  }

  void onMessage(String event) {
    message = event;
    setState(() {});
  }
}
