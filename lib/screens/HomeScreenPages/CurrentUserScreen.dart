import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentUserScreen extends StatefulWidget {
  @override
  _CurrentUserScreenState createState() => _CurrentUserScreenState();
}

class _CurrentUserScreenState extends State<CurrentUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Center(child: Icon(Icons.account_circle, size: 120)),
          ),
          RoundedButton(
              width: 300,
              colour: kRedColor,
              title: 'Logout',
              onPressed: () {
                Authentication().logout();
                Provider.of<UiState>(context, listen: false)
                    .setBottomNavBarIndex(1);
                Navigator.pushNamed(context, StartScreen.id);
              })
        ],
      ),
    );
  }
}
