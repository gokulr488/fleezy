import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/VehicleOverviewScreen.dart';
import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard(
      {this.color,
      this.currentDriver,
      this.message,
      this.registrationNumber,
      this.vehicle,
      this.vehicleName});
  static const TextStyle _kRegistrationNumberTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kTextColor);
  static const TextStyle _kDriverTextStyle =
      TextStyle(fontSize: 17, color: kTextColor, fontWeight: FontWeight.bold);
  static const TextStyle _kMessagesTextStyle =
      TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
  final Color color;
  final String registrationNumber;
  final String currentDriver;
  final String message;
  final String vehicleName;
  final ModelVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 120,
              child: Image.asset(
                'assets/images/startPageImage.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(registrationNumber ?? '',
                  style: _kRegistrationNumberTextStyle),
              Text(vehicleName ?? '', style: _kDriverTextStyle),
              Text('Driver: $currentDriver', style: _kDriverTextStyle),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(message ?? '', style: _kMessagesTextStyle)))
            ],
          )
        ],
      ),
      elevation: 4,
      color: color,
      onTap: () {
        Navigator.pushNamed(context, VehicleOverviewScreen.id, arguments: this);
      },
    );
  }
}
