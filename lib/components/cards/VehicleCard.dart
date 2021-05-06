import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/VehicleOverviewScreen.dart';
import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  static const TextStyle _kRegistrationNumberTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kWhite80);
  static const TextStyle _kDriverTextStyle =
      TextStyle(fontSize: 17, color: kWhite80);
  static const TextStyle _kMessagesTextStyle = TextStyle(color: Colors.red);
  final Color color;
  final String registrationNumber;
  final String currentDriver;
  final String message;
  final ModelVehicle vehicle;

  const VehicleCard(
      {this.color,
      this.currentDriver,
      this.message,
      this.registrationNumber,
      this.vehicle});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 100,
              child: Image.asset(
                'assets/images/startPageImage.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(registrationNumber ?? '',
                  style: _kRegistrationNumberTextStyle),
              Text('Driver: ' + currentDriver, style: _kDriverTextStyle),
              Container(
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
