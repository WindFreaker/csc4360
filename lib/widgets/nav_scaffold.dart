import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/navigation_wrapper.dart';

class NavigationScaffold extends StatelessWidget {

  final String title;
  final Widget contents;
  final double padding;

  NavigationScaffold({required this.title, required this.contents, this.padding = 30});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: AssetImage('assets/drawer_background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Text('Austin Farmer\'s\nMidterm Project'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Message Boards'),
              onTap: () {
                ChangeRoute(context, '/message_boards').replaceRoot();
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                if (AuthWrapper.anonymous) {
                  ChangeRoute(context, '/new_user').replaceRoot();
                } else {
                  ChangeRoute(context, '/edit_profile').replaceRoot();
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                ChangeRoute(context, '/settings').replaceRoot();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: contents,
        ),
      ),
    );
  }
}
