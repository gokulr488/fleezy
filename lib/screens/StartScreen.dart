import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

TextStyle fleezyTextStyle = TextStyle(
    fontSize: 60,
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.bold,
    color: kHighlightColour);
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
        children: [
          Expanded(
            child: Center(
              child: Text(
                'FleeZy',
                style: fleezyTextStyle,
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
          SizedBox(height: 15),
          RoundedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.id);
            },
            title: 'Log In',
            colour: kBlueColor,
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String buttonText;

  const Button({this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Text(
          buttonText,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
