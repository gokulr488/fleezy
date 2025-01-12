import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/GridLayout.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/StartNewTripScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addexpense/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addfuel/AddFuelScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryScreen.dart';
import 'package:flutter/material.dart';

class VehicleOverviewScreen extends StatelessWidget {
  static const String id = 'vehicleOverviewScreen';
  static const TextStyle cardTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final VehicleCard vehicle =
        ModalRoute.of(context).settings.arguments as VehicleCard;
    return BaseScreen(
        headerText: 'Vehicle Overview',
        child: Column(children: [
          IgnorePointer(child: vehicle),
          const SizedBox(height: 15),
          GridLayout(
            children: [
              ButtonCard(
                  text: 'Start a Trip',
                  icon: Icons.add_road,
                  onTap: () {
                    if (!vehicle.vehicle.isInTrip) {
                      Navigator.pushNamed(context, StartNewTripScreen.id,
                          arguments: vehicle);
                    } else {
                      showErrorAlert(context, 'Already in TRIP');
                    }
                  }),
              ButtonCard(
                  text: 'Add Fuel',
                  icon: Icons.add_circle_rounded,
                  onTap: () {
                    Navigator.pushNamed(context, AddFuelScreen.id,
                        arguments: vehicle.registrationNumber);
                  }),
              ButtonCard(
                  text: 'Add Expense',
                  icon: Icons.add_shopping_cart,
                  onTap: () {
                    Navigator.pushNamed(context, AddExpenseScreen.id,
                        arguments: vehicle.registrationNumber);
                  }),
              ButtonCard(
                text: 'Pending Balance',
                icon: Icons.attach_money,
                onTap: () {
                  Navigator.pushNamed(context, PendingBalanceScreen.id,
                      arguments: vehicle.registrationNumber);
                },
              ),
              ButtonCard(
                text: 'Trip History',
                icon: Icons.location_on,
                onTap: () {
                  Navigator.pushNamed(context, TripHistoryScreen.id,
                      arguments: vehicle.registrationNumber);
                },
              ),
              ButtonCard(
                text: 'Expenses History',
                icon: Icons.history,
                onTap: () {
                  showErrorAlert(context, 'Under Development');
                },
              ),
            ],
          ),
        ]));
  }
}
