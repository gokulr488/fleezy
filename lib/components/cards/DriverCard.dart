import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const TextStyle _kDriverNameTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: kWhite80);

class DriverCard extends StatelessWidget {
  final ModelUser user;

  const DriverCard({this.user});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
        cardChild: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(user.fullName ?? '', style: _kDriverNameTextStyle),
                        Text(user.phoneNumber ?? '',
                            style: _kDriverNameTextStyle)
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                            onPressed: edit, title: 'Edit', width: 120),
                        RoundedButton(
                            onPressed: () {
                              deactivate(context);
                            },
                            title: user.state == Constants.ACTIVE
                                ? 'De-Activate'
                                : 'Activate',
                            width: 120)
                      ])
                ])),
        color: user.state == Constants.ACTIVE ? kActiveColor : kCardOverlay[4]);
  }

  edit() {}

  deactivate(BuildContext context) async {
    user.state == Constants.INACTIVE
        ? user.state = Constants.ACTIVE
        : user.state = Constants.INACTIVE;
    CallContext callContect = await Roles().updateRole(user);
    if (callContect.isError) {
      // show warning pop up
    } else {
      AppData appData = Provider.of<AppData>(context, listen: false);
      appData.updateDriver(user);
    }
  }
}
