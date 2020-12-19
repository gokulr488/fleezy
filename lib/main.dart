import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fleezy/screens/AddVehicleScreen.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/LoginScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:fleezy/screens/VehicleOverViewScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddFuelScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/StartNewTripScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FleezyApp());
}

class FleezyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'Fleezy',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: _isLoggedIn() ? HomeScreen.id : StartScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          StartScreen.id: (context) => StartScreen(),
          CreateCompanyScreen.id: (context) => CreateCompanyScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          AddVehicleScreen.id: (context) => AddVehicleScreen(),
          VehicleOverviewScreen.id: (context) => VehicleOverviewScreen(),
          StartNewTripScreen.id: (context) => StartNewTripScreen(),
          AddFuelScreen.id: (context) => AddFuelScreen(),
          AddExpenseScreen.id: (context) => AddExpenseScreen(),
        });
  }
}

bool _isLoggedIn() {
  final _auth = FirebaseAuth.instance;
  if (_auth.currentUser != null) {
    return true;
  } else {
    return false;
  }
}
