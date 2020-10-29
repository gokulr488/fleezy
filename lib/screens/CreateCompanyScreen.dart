import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class CreateCompanyScreen extends StatefulWidget {
  static const String id = 'createCompanyScreen';
  @override
  _CreateCompanyScreenState createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  static const TextStyle kFleezyTextStyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
  final _auth = FirebaseAuth.instance;
  String companyName;
  String emailId;
  String password;
  String confirmPassword;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              decoration: kTextFieldDecoration.copyWith(hintText: 'email ID'),
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter a new password'),
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                confirmPassword = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Confirm your password'),
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.blue,
              onPressed: () {
                if (password != confirmPassword) {
                  print('Passwords does not match');
                  return;
                }
                setState(() {
                  showSpinner = true;
                });
                createAndSaveCompany();
              },
            ),
          ],
        ),
      )),
    );
  }

  void createAndSaveCompany() async {
    try {
      final UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: emailId,
        password: password,
      );

      if (user != null) {
        Navigator.pushNamed(context, HomeScreen.id);
      }

      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
