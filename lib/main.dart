import 'package:csc4360/wrappers/prefs_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:csc4360/routes/favorite_services.dart';
import 'package:csc4360/routes/all_services.dart';
import 'package:csc4360/routes/detailed_status.dart';
import 'package:csc4360/routes/settings.dart';

Map<String, Widget Function(BuildContext)> routesList = {
  '/favorite_services': (context) => FavoriteServices(),
  '/all_services': (context) => AllServices(),
  '/detailed_status': (context) => DetailedStatus(),
  '/settings': (context) => Settings(),
};

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // removes the ugly old android look by making the top and bottom bars transparent
  // TODO SystemChrome.setEnabledSystemUIMode(SystemUIMode.edgeToEdge); should work in Flutter 2.4
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  await Firebase.initializeApp();

  ThemeMode themeChoice = await getPrefThemeMode();

  runApp(FinalProject(themeChoice));

}

class FinalProject extends StatelessWidget {

  final ThemeMode _themeChoice;
  FinalProject(this._themeChoice);

  @override
  Widget build(BuildContext context) {
    // if user is not signed in...
    if (!AuthWrapper.signedIn) {

      // ...sign the user in with an anonymous account
      anonymousAuth();
      print('Not signed in, creating anonymous account...');

    }

    return MaterialApp(
      routes: routesList,
      initialRoute: '/favorite_services',
      themeMode: _themeChoice,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.blueAccent,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.blueAccent,
      ),
    );
  }

}
