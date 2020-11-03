import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailId;
  String password;
  bool showSpinner = false;
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
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                emailId = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email ID'),
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your Password'),
            ),
            showSpinner ? LoadingDots(size: 50) : SizedBox(height: 10),
            RoundedButton(
              title: 'Log In',
              colour: Colors.blue,
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                if (emailId == null || password == null) {
                  print('Email or password not Provided');
                  return;
                }
                setState(() {
                  showSpinner = true;
                });
                print(showSpinner);
                ModelUser user =
                    ModelUser(userEmailId: emailId, password: password);
                bool loggedIn = await Authentication().login(user);
                setState(() {
                  showSpinner = false;
                });
                if (loggedIn) {
                  Navigator.pushNamed(context, HomeScreen.id);
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
