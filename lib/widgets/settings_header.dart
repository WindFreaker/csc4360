import 'package:flutter/material.dart';

import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';

class AnonAccountHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Want to backup your account?',
          textAlign: TextAlign.center,
        ),
        SignInButton(
          Buttons.Google,
          onPressed: () async {
            await googleAuth();
            ChangeRoute(context, '/favorite_services').replaceRoot();
          },
        ),
        Text(
          'Anonymous Account ID\n${AuthWrapper.selfUID}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

}

class GoogleAccountHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Account settings are currently backed up.',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          child: Text('Sign out'),
          onPressed: () async {
            await signOut();
            await anonymousAuth();
            ChangeRoute(context, '/favorite_services').replaceRoot();
          },
        ),
        Text(
          'Google Account ID\n${AuthWrapper.selfUID}',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

}

