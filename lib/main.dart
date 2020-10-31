import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fleezy/screens/CreateCompanyScreen.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/LoginScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
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
