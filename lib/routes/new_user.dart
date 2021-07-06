import 'package:flutter/material.dart';

import 'package:csc4360/widgets/custom_buttons.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';

class NewUser extends StatelessWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Austin Farmer\'s\nMessage Board App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
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
                height: 30,
              ),
              SignInButton(
                Buttons.Google,
                onPressed: () async {
                  await googleAuth();
                  ChangeRoute(context, '/message_boards').replaceRoot();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}