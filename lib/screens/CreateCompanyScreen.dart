import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Authentication.dart';
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
  final _auth = FirebaseAuth.instance;
  String companyName;
  String emailId;
  String password;
  String phoneNumber;
  String confirmPassword;
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
            showSpinner ? LoadingDots(size: 40) : SizedBox(width: 10),
            RoundedButton(
              title: 'Create Company',
              colour: Colors.blue,
              onPressed: () async {
                if (companyName == null ||
                    emailId == null ||
                    phoneNumber == null) {
                  print('Some fields are left empty');
                  return;
                }
                FocusScope.of(context).requestFocus(FocusNode());

                setState(() {
                  showSpinner = true;
                });
                ModelCompany modelCompany = ModelCompany(
                    companyEmail: emailId,
                    phoneNumber: phoneNumber,
                    companyName: companyName);
                await Authentication().addNewCompany(modelCompany);
                setState(() {
                  showSpinner = false;
                });
                // Navigator.pushNamed(context, HomeScreen.id);
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
