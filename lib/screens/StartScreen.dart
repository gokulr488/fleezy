import 'package:fleezy/components/BaseCard.dart';
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
              onTap: () {},
              cardChild: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Create Company',
                    style: buttonTextStyle,
                  ),
                ),
              ),
              color: Color(0xFF9fb3d2),
            ),
            BaseCard(
              onTap: () {},
              cardChild: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'Log In',
                    style: buttonTextStyle,
                  ),
                ),
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
