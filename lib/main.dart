import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:csc4360/routes/favorite_apps.dart';
import 'package:csc4360/routes/all_apps.dart';
import 'package:csc4360/routes/detailed_status.dart';
import 'package:csc4360/routes/account.dart';

Map<String, Widget Function(BuildContext)> routesList = {
  '/favorite_apps': (context) => FavoriteApps(),
  '/all_apps': (context) => AllApps(),
  '/detailed_status': (context) => DetailedStatus(),
  '/account': (context) => Account(),
};

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(ChatApp());

}

class ChatApp extends StatelessWidget {

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
      initialRoute: '/favorite_apps',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.orangeAccent,
      ),
    );

  }

}
