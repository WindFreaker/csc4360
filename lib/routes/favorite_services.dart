import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:csc4360/widgets/custom_scaffold.dart';
import 'package:csc4360/widgets/service_status_card.dart';
import 'package:csc4360/data/service.dart';
import 'package:csc4360/data/services_list.dart';
import 'package:csc4360/wrappers/prefs_wrapper.dart';

class FavoriteServices extends StatefulWidget {
  const FavoriteServices({Key? key}) : super(key: key);

  @override
  _FavoriteServicesState createState() => _FavoriteServicesState();
}

class _FavoriteServicesState extends State<FavoriteServices> {

  List<String> _favorites = [];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Favorites',
      contents: FutureBuilder(
        future: _getFavoritesList(),
        builder: (BuildContext context, _) {
          return ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: _favorites.length,
            itemBuilder: (_, int index) {
              String serviceID = _favorites[index];
              Service service = servicesMap[serviceID]!;
              return ServiceStatusCard(service);
            },
          );
        }
      ),
      appBarActions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            ChangeRoute(context, '/settings').addOnTop();
          },
        ),
      ],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add),
        onPressed: () {

          ChangeRoute(context, '/all_services').withData({
            'favorites': _favorites,
          }).addOnTop().then((_) => setState(() {}));
          // the then statement refreshes the state after upon returning to this screen

        },
      ),
    );
  }

  Future<void> _getFavoritesList() async {
    _favorites = await favoriteServices.getList();
  }

}

// TODO make the favorites list order-able
// this is possible because the list in which the elements are loaded depends on _favorites
// modifying this order in UI is a potentially nice feature to implement someday