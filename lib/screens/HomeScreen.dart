import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/AddVehicleScreen.dart';
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
  static ModelUser user;
  static const String id = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //ModelUser user;
  int bottomNavBarIndex = 2;
  List<VehicleCard> vehicles = [];
  bool dataLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserData(context);
    });
  }

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
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _HeaderWidget(
            userName: HomeScreen.user?.phoneNumber ?? '',
          ),
          Expanded(
            child: ScrollableList(
              childrenHeight: 120,
              items: vehicles,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              size: 40,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AddVehicleScreen.id);
            },
          ),
          TextField(
              onChanged: (value) {
                searchKeyword = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Search')),
        ],
      ),
      bottomNavBar: BottomNavBar(
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

  Future<void> getUserData(BuildContext context) async {
    HomeScreen.user = ModalRoute.of(context).settings.arguments;
    if (HomeScreen.user == null) {
      print('Getting User basic Info.');
      HomeScreen.user =
          await Roles().getUser(Authentication().getUser().phoneNumber);
    }
    setState(() {});
  }
}

class _HeaderWidget extends StatelessWidget {
  final String userName;
  final String screenName;

  const _HeaderWidget({this.userName, this.screenName});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hi $userName', style: kWelcomeUserTextStyle),
              Text('Fleezy', style: _kFleezyTextStyle)
            ]),
        SizedBox(height: 10),
        Text('Our Vehicles', style: _kOurVehiclesTextStyle),
        SizedBox(height: 10),
      ],
    );
  }
}
