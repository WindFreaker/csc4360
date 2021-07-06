import 'package:flutter/material.dart';

import 'package:csc4360/widgets/nav_scaffold.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return NavigationScaffold(
      title: 'Settings',
      body: ElevatedButton(
        child: Text('Sign out'),
        onPressed: () async {
          await signOut();
          ChangeRoute(context, '/new_user').replaceRoot();
        },
      ),
    );
  }
}
