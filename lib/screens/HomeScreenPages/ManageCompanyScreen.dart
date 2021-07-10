import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/components/GridLayout.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/screens/ManageDriverScreens/ManageDriversScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehiclesScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceScreen.dart';
import 'package:fleezy/screens/reports/ReportsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCompanyScreen extends StatefulWidget {
  @override
  _ManageCompanyScreenState createState() => _ManageCompanyScreenState();
}

class _ManageCompanyScreenState extends State<ManageCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    final uiState = Provider.of<UiState>(context, listen: false);
    return uiState.isAdmin
        ? Column(
            children: [
              Text('Manage Company', style: kHeaderTextStyle),
              SizedBox(height: 10),
              GridLayout(children: [
                ButtonCard(
                    text: 'Manage Vehicles',
                    icon: Icons.car_repair,
                    onTap: () {
                      Navigator.pushNamed(context, ManageVehiclesScreen.id);
                    }),
                ButtonCard(
                    text: 'Manage Drivers',
                    icon: Icons.account_circle,
                    onTap: () {
                      Navigator.pushNamed(context, ManageDriversScreen.id);
                    }),
                ButtonCard(
                    text: 'Reports',
                    icon: Icons.receipt_long_rounded,
                    onTap: () {
                      Navigator.pushNamed(context, ReportsScreen.id);
                    }),
                ButtonCard(
                  text: 'Pending Balances',
                  icon: Icons.attach_money,
                  onTap: () {
                    Navigator.pushNamed(context, PendingBalanceScreen.id);
                  },
                ),
              ]),
            ],
          )
        : BaseCard(
            elevation: 1,
            cardChild: SizedBox(
              height: 100,
              child: Center(
                  child: Text(
                'Available for Company Administrators only',
                style: TextStyle(fontSize: 17),
              )),
            ),
          );
  }
}
