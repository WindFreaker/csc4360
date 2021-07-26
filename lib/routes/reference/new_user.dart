import 'package:flutter/material.dart';

import 'package:csc4360/widgets/custom_buttons.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:csc4360/widgets/nav_scaffold.dart';

class NewUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return NavigationScaffold(
      title: 'Profile',
      contents: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          ButtonRow(
            buttons: <ButtonStyleButton>[
              ElevatedButton(
                onPressed: () {
                  ChangeRoute(context, '/user_signup').addOnTop();
                },
                child: Text('Sign up'),
              ),
              ElevatedButton(
                onPressed: () {
                  ChangeRoute(context, '/user_login').addOnTop();
                },
                child: Text('Login'),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          SignInButton(
            Buttons.Google,
            onPressed: () async {
              await googleAuth();
              ChangeRoute(context, '/edit_profile').replaceRoot();
            },
          ),
        ],
      ),
    );
  }

}