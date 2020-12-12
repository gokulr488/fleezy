import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';

class VehicleOverviewScreen extends StatefulWidget {
  static const String id = 'vehicleOverviewScreen';
  @override
  _VehicleOverviewScreenState createState() => _VehicleOverviewScreenState();
}

class _VehicleOverviewScreenState extends State<VehicleOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    VehicleCard vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
      child: Column(
        children: [vehicle],
      ),
    );
  }
}
