import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryDetailController.dart';
import 'package:flutter/material.dart';

class TripHistoryDetailsScreen extends StatelessWidget {
  static const String id = 'TripHistoryDetailsScreen';

  @override
  Widget build(BuildContext context) {
    ModelTrip tripDo = ModalRoute.of(context).settings.arguments as ModelTrip;
    getExpenses(tripDo, context);
    return BaseScreen(
      headerText: 'Trip Summary',
      child: SingleChildScrollView(
        child: Column(
          children: [
            TripDetailCard(tripDo: tripDo),
            HorLine(),
            Text('Expenses', style: TextStyle(fontSize: 18, color: kWhite80)),
          ],
        ),
      ),
    );
  }
}
