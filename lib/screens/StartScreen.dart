import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const TextStyle buttonTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class StartScreen extends StatelessWidget {
  static const String id = 'startScreen';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      headerText: '',
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'FleeZy',
                style: GoogleFonts.dancingScript(
                    color: kHighlightColour,
                    shadows: shadow,
                    fontWeight: FontWeight.bold,
                    fontSize: 60),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Image.asset(
              'assets/images/startPageImage.jpg',
              colorBlendMode: BlendMode.darken,
            ),
          ),
          RoundedButton(
            onPressed: () {
              Navigator.pushNamed(context, CreateCompanyScreen.id);
            },
            title: 'Create Company',
          ),
          const SizedBox(height: 15),
          RoundedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            title: 'Log In',
            colour: kBlueColor,
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
