import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:flutter/material.dart';

const _kHeaderTextStyle = TextStyle(
    fontSize: 30, fontWeight: FontWeight.bold, color: kHighlightColour);

class AddDriverScreen extends StatefulWidget {
  static const String id = 'AddDriverScreen';
  @override
  _AddDriverScreenState createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  ModelUser user = ModelUser();
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        headerText: 'Add New User',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('User Details', style: _kHeaderTextStyle),
            SizedBox(height: 20),
            Expanded(
              child: ScrollableList(childrenHeight: 80, items: [
                TextField(
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      user.fullName = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: 'Full Name')),
                TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      user.phoneNumber = '+91' + value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Phone Number')),
                TextField(
                    onChanged: (value) {
                      user.userEmailId = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: 'Email ID')),
                DropDown(
                    defaultValue: Constants.DRIVER,
                    values: [Constants.ADMIN, Constants.DRIVER],
                    hintText: 'User Type',
                    onChanged: (String value) {
                      user.roleName = value;
                    })
              ]),
            ),
            ButtonCard(onTap: _addDriverToDb, buttonText: 'Add Driver')
          ],
        ));
  }

  _addDriverToDb() {}
}
