import 'package:flutter/material.dart';

class ChangeRoute {

  // required variables
  BuildContext _context;
  String _routeName;

  // optional variables
  Map<String, dynamic>? _data;

  ChangeRoute(this._context, this._routeName);

  ChangeRoute withData(Map<String, dynamic> data) {
    _data = data;
    return this;
  }

  Future addOnTop() {
    return Navigator.pushNamed(_context, _routeName, arguments: _data);
  }

  Future replaceRoot() {
    return Navigator.pushNamedAndRemoveUntil(_context, _routeName, (route) => false, arguments: _data);
  }

}

Map<String, dynamic> getRoutingData(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
}