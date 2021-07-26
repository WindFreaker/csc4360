import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/navigation_wrapper.dart';

class FavoriteApps extends StatefulWidget {
  const FavoriteApps({Key? key}) : super(key: key);

  @override
  _FavoriteAppsState createState() => _FavoriteAppsState();
}

class _FavoriteAppsState extends State<FavoriteApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your apps'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add),
        onPressed: () {
          ChangeRoute(context, '/all_apps').addOnTop();
        },
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(5),
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.developer_mode),
                          Column(
                            children: <Widget>[
                              Text('app name here'),
                              Text('app status here'),
                            ],
                          ),
                        ],
                      ),
                      Text('this is the potential warning line'),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
