import 'package:fleezy/DataAccess/Authentication.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavBarIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('data')),
      bottomNavigationBar: BottomNavBar(
        onTap: (index) {
          print(index);
          bottomNavBarIndex = index;
          if (bottomNavBarIndex == 4) {
            Authentication().logout();
            Navigator.pushNamed(context, StartScreen.id);
          }
        },
      ),
    );
  }
}
