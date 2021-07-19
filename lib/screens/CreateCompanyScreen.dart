import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/CreateCompanyController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextStyle _kMessagesTextStyle = TextStyle(fontSize: 15);

class CreateCompanyScreen extends StatefulWidget {
  static const String id = 'createCompanyScreen';
  @override
  _CreateCompanyScreenState createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  CreateCompanyController ctrl = CreateCompanyController();
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text('FleeZy',
              style: GoogleFonts.dancingScript(
                  color: kHighlightColour,
                  shadows: shadow,
                  fontWeight: FontWeight.bold,
                  fontSize: 60)),
          TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                ctrl.company.companyName = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(labelText: 'Company Name')),
          TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                ctrl.company.companyEmail = value;
              },
              decoration: kTextFieldDecoration.copyWith(labelText: 'Email ID')),
          TextField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              onChanged: (value) {
                ctrl.company.phoneNumber = '+91$value'; //TODO change this impl
              },
              decoration:
                  kTextFieldDecoration.copyWith(labelText: 'Phone number')),
          Visibility(
              visible: ctrl.verified,
              child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    ctrl.otp = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(labelText: 'OTP'))),
          Visibility(visible: ctrl.showSpinner, child: LoadingDots(size: 40)),
          Text(message, style: _kMessagesTextStyle),
          RoundedButton(
              title: ctrl.verified ? 'Login' : 'Send OTP',
              onPressed: () async {
                await ctrl.onButtonPressed(context);
                setState(() {});
              })
        ]));
  }

  void onUserStreamEvent(User user) async {
    if (ctrl.allowCompanyRegistration) {
      ctrl.allowCompanyRegistration = false;
      if (user == null) {
        print('Create Company Screen: User is currently signed out!');
      } else {
        ctrl.showSpinner = true;
        ctrl.disableButton = true;
        setState(() {});
        await ctrl.onVerificationCompleted(context);
        print('User signed in!');
      }
    }
  }

  void onMessage(String event) {
    message = event;
    print(message);
    setState(() {});
  }
}
