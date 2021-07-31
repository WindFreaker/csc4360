import 'package:flutter/material.dart';

import 'package:csc4360/widgets/custom_scaffold.dart';
import 'package:csc4360/data/services_list.dart';
import 'package:csc4360/data/service.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:csc4360/wrappers/prefs_wrapper.dart';

class AllServices extends StatefulWidget {
  const AllServices({Key? key}) : super(key: key);

  @override
  _AllServicesState createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {

  List<String>? favorites;

  @override
  Widget build(BuildContext context) {

    if (favorites == null) {
      var routingData = getRoutingData(context);
      favorites = routingData['favorites'];
    }

    return CustomScaffold(
      title: 'All Services',
      contents: ListView.builder(
        itemCount: servicesList.length,
        itemBuilder: (_, int index) {

          Service service = servicesList[index];
          bool state = favorites!.contains(service.id);

          return ListTile(
            title: Text(
              service.displayName,
            ),
            leading: Image.asset(
              'assets/services/${service.id}-logo.png',
              width: 48,
              height: 48,
            ),
            trailing: IconButton(
              icon: Icon(
                state ? Icons.star : Icons.star_border,
                color: state ? null : Theme.of(context).disabledColor,
              ),
              onPressed: () async {
                bool newState = await favoriteServices.toggleValue(service.id);
                setState(() {
                  if (newState) {
                    favorites!.add(service.id);
                  } else {
                    favorites!.remove(service.id);
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }

}
