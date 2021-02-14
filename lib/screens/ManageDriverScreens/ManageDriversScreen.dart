import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/screens/ManageDriverScreens/AddDriverScreen.dart';
import 'package:flutter/material.dart';

class ManageDriversScreen extends StatelessWidget {
  static const String id = 'ManageDriversScreen';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          ButtonCard(
              buttonText: 'Add New Driver',
              onTap: () {
                Navigator.pushNamed(context, AddDriverScreen.id);
              })
        ],
      ),
    );
  }
}
