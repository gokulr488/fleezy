import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:flutter/material.dart';

const _kOurVehiclesTextStyle =
    TextStyle(fontSize: 30, fontFamily: 'FundamentoRegular');
const kWelcomeUserTextStyle = TextStyle(
    fontSize: 18, fontFamily: 'FundamentoRegular', fontWeight: FontWeight.bold);
const _kFleezyTextStyle = TextStyle(
    fontSize: 45,
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.bold,
    color: kHighlightColour);

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authUser = FirebaseAuth.instance.currentUser;
  List<VehicleCard> vehicles = [];
  bool dataLoaded = false;
  @override
  void initState() {
    super.initState();
    if (_authUser != null) {
      print(_authUser.phoneNumber);
    }
  }

  int bottomNavBarIndex = 2;
  @override
  Widget build(BuildContext context) {
    vehicles = [
      VehicleCard(
        color: Colors.green[800],
        currentDriver: 'Rajesh',
        registrationNumber: 'KL-01-BS-2036',
        message: 'Insurance Due on 01/01/2021',
      ),
      VehicleCard(
        color: Colors.grey[800],
        currentDriver: 'Shine',
        registrationNumber: 'KL-01-BF-1234',
        message: 'Tax Due on 01/01/2021',
      ),
    ];
    String searchKeyword = '';
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Hi Gokul', style: kWelcomeUserTextStyle),
              Text('Fleezy', style: _kFleezyTextStyle)
            ]),
            //
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   child: Text('Fleezy',
            //       style: _kFleezyTextStyle, textAlign: TextAlign.center),
            // ),
            // SizedBox(height: 10),
            // Text('Hi Gokul', style: kWelcomeUserTextStyle),
            SizedBox(height: 10),
            Text('Our Vehicles', style: _kOurVehiclesTextStyle),
            SizedBox(height: 10),
            Expanded(
              child: ScrollableList(
                childrenHeight: 120,
                items: vehicles,
              ),
            ),
            TextField(
                onChanged: (value) {
                  searchKeyword = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Search')),
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
