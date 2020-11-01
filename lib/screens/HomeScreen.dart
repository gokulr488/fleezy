import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/UiConstants.dart';
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
  bool dataLoaded = false;
  @override
  void initState() {
    super.initState();
    final _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      print(_auth.currentUser.email);
    }
  }

  int bottomNavBarIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Our Vehicles',
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      )),
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
