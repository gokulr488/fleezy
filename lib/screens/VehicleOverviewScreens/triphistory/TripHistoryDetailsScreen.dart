import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryDetailController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripHistoryDetailsScreen extends StatefulWidget {
  static const String id = 'TripHistoryDetailsScreen';

  @override
  _TripHistoryDetailsScreenState createState() =>
      _TripHistoryDetailsScreenState();
}

class _TripHistoryDetailsScreenState extends State<TripHistoryDetailsScreen> {
  TripHistoryDetailController ctrl = TripHistoryDetailController();

  @override
  Widget build(BuildContext context) {
    ModelTrip tripDo = ModalRoute.of(context).settings.arguments as ModelTrip;
    getExpenses(tripDo, context);
    return BaseScreen(
      headerText: 'Trip Summary',
      child: Column(
        children: [
          TripDetailCard(tripDo: tripDo),
          HorLine(),
          Text('Expenses', style: TextStyle(fontSize: 18, color: kWhite80)),
          Consumer<AppData>(builder: (context, misData, _) {
            if (ctrl.expenseCards == null) return LoadingDots(size: 100);

            return Expanded(
              child:
                  ScrollableList(childrenHeight: 170, items: ctrl.expenseCards),
            );
          })
        ],
      ),
    );
  }

  void getExpenses(ModelTrip tripDo, BuildContext context) async {
    await ctrl.getExpenses(tripDo, context);
    setState(() {});
  }
}
