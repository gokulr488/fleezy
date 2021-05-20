import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const TextStyle _kLabelTS = TextStyle(fontSize: 16, color: Colors.white54);
const TextStyle _kFieldTS = TextStyle(fontSize: 18);

class CurrentUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: false);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.account_circle,
            size: 100,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_circle, size: 18),
                        SizedBox(width: 10),
                        Text('Name', style: _kLabelTS),
                      ],
                    ),
                    _EditNameWidget(),
                    HorLine(),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 18),
                        SizedBox(width: 10),
                        Text('Phone Number', style: _kLabelTS),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(appData.user.phoneNumber ?? '', style: _kFieldTS),
                    HorLine(),
                    Row(
                      children: [
                        Icon(Icons.info_outline, size: 18),
                        SizedBox(width: 10),
                        Text('User Type', style: _kLabelTS),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(appData.user.roleName ?? '', style: _kFieldTS),
                    HorLine(),
                  ],
                ),
              ),
            ),
          ),
          RoundedButton(
              colour: kRedColor,
              title: 'Logout',
              onPressed: () {
                Authentication().logout();

                Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
                Navigator.pushReplacementNamed(context, StartScreen.id);
              })
        ],
      ),
    );
  }
}

class _EditNameWidget extends StatefulWidget {
  @override
  __EditNameWidgetState createState() => __EditNameWidgetState();
}

class __EditNameWidgetState extends State<_EditNameWidget> {
  bool isEditEnabled = false;

  TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: false);
    nameController = TextEditingController(text: appData.user.fullName ?? '');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isEditEnabled
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  decoration: kTextFieldDecoration,
                ),
              )
            : Text(appData.user.fullName ?? '', style: _kFieldTS),
        IconButton(
            icon: Icon(isEditEnabled ? Icons.check_circle : Icons.edit),
            onPressed: () => onPressed(appData)),
      ],
    );
  }

  onPressed(AppData appData) async {
    if (!isEditEnabled) {
      isEditEnabled = !isEditEnabled;
      setState(() {});
      return;
    }
    ModelUser user = appData.user;
    user.fullName = nameController.text;
    CallContext callContext = await Roles().updateRole(user);
    if (callContext.isError) {
      showErrorAlert(context, 'Unable to modify Name');
      return;
    }
    appData.setUser(user);
    isEditEnabled = !isEditEnabled;
    setState(() {});
  }
}
