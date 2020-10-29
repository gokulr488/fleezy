import 'package:fleezy/components/BaseCard.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const TextStyle fleezyTextStyle = TextStyle(
  color: Color(0xFFd17008),
  fontSize: 60,
);
const TextStyle buttonTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

class StartScreen extends StatefulWidget {
  static const String id = 'startScreen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'FLEEZY',
                  style: fleezyTextStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: Image.asset(
                'assets/images/startPageImage.jpg',
                colorBlendMode: BlendMode.darken,
              ),
            ),
            BaseCard(
              onTap: () {
                Navigator.pushNamed(context, CreateCompanyScreen.id);
              },
              cardChild: Button(
                buttonText: 'Create Company',
              ),
              color: Color(0xFF9fb3d2),
            ),
            BaseCard(
              onTap: () {},
              cardChild: Button(
                buttonText: 'Log In',
              ),
              color: Color(0xFF1A54F8),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
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
