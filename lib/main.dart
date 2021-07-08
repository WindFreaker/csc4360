import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:csc4360/routes/home.dart';

import 'package:csc4360/routes/new_user.dart';
import 'package:csc4360/routes/user_signup.dart';
import 'package:csc4360/routes/user_login.dart';

import 'package:csc4360/routes/message_boards.dart';
import 'package:csc4360/routes/edit_profile.dart';
import 'package:csc4360/routes/settings.dart';

import 'package:csc4360/routes/open_chat.dart';

Map<String, Widget Function(BuildContext)> routesList = {
  '/home': (context) => Home(),
  '/new_user': (context) => NewUser(),
  '/user_signup': (context) => UserSignUp(),
  '/user_login': (context) => UserLogin(),
  '/message_boards': (context) => MessageBoards(),
  '/edit_profile': (context) => EditProfile(),
  '/settings': (context) => Settings(),
  '/open_chat': (context) => OpenChat(),
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

      // ...sign the user in with an anonymous "account"
      anonymousAuth();
      print('Not signed in, using anonymous mode...');

    }

    return MaterialApp(
      routes: routesList,
      initialRoute: '/message_boards',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );

  }

}
