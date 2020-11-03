import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

const TextStyle kFleezyTextStyle =
    TextStyle(fontSize: 35, fontWeight: FontWeight.bold);

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
  Authentication auth = Authentication();
  @override
  Widget build(BuildContext context) {
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
              textAlign: TextAlign.center,
              onChanged: (value) {
                phoneNumber = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Phone number'),
            ),
            verified
                ? TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      otp = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'OTP'),
                  )
                : SizedBox(
                    width: 10,
                  ),
            showSpinner ? LoadingDots(size: 40) : SizedBox(width: 10),
            RoundedButton(
              title: verified ? 'Login' : 'Send OTP',
              colour: Colors.blue,
              onPressed: () async {
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

  Future<void> verify() async {
    await auth.verifyPhone(phoneNumber);
    if (auth.isLoggedIn()) {
      Navigator.pushNamed(context, HomeScreen.id);
    } else {
      setState(() {
        verified = true;
      });
    }
  }

  Future<void> login() async {
    await auth.signInWithOTP(otp);
    ModelCompany modelCompany = ModelCompany(
        companyEmail: emailId,
        phoneNumber: phoneNumber,
        companyName: companyName);
  }
}
