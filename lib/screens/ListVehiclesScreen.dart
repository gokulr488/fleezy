import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataAccess/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/AddVehicleScreen.dart';
import 'package:fleezy/screens/HomeScreen.dart';
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

class ListVehiclesScreen extends StatefulWidget {
  static const String id = 'ListVehiclesScreen';
  @override
  _ListVehiclesScreenState createState() => _ListVehiclesScreenState();
}

class _ListVehiclesScreenState extends State<ListVehiclesScreen> {
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
    String searchKeyword = '';
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
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
            onPressed: () async {
              final vehicle =
                  await Navigator.pushNamed(context, AddVehicleScreen.id);
              if (vehicle != null) {
                vehicles.add(_getVehicleCard(vehicle));
                setState(() {});
              }
            },
          ),
          TextField(
              onChanged: (value) {
                searchKeyword = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Search')),
        ],
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
    getVehicleList();
  }

  void getVehicleList() async {
    List<ModelVehicle> vehiclesData =
        await Vehicle().getVehiclesForUser(HomeScreen.user);
    if (vehiclesData != null && vehiclesData.isNotEmpty) {
      for (ModelVehicle vehicle in vehiclesData) {
        vehicles.add(_getVehicleCard(vehicle));
      }
      setState(() {});
    }
  }

  VehicleCard _getVehicleCard(ModelVehicle vehicle) {
    return VehicleCard(
        registrationNumber: vehicle.registrationNo,
        color: vehicle.isInTrip ? kActiveVehicleColor : kInActiveVehicleColor,
        currentDriver: vehicle.currentDriver ?? '',
        message: ModelVehicle.getWarningMessage(vehicle));
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
