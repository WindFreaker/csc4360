import 'package:flutter/material.dart';

import 'package:csc4360/data/services_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsStringList {

  String key;
  List<String> defaults;

  PrefsStringList({
    required this.key,
    this.defaults = const [],
  });

  Future<List<String>> getList() async {

    final prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList(key);

    if (list == null) {
      list = defaults;
    }

    return list;

  }

  Future<bool> toggleValue(String value) async {

    List<String> list = await getList();
    bool contains = list.contains(value);

    if (contains) {
      list.remove(value);
    } else {
      list.add(value);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, list);

    return !contains;

  }

}

var favoriteServices = PrefsStringList(
  key: 'favorites',
  defaults: <String>[
    servicesList[0].id,
    servicesList[1].id,
    servicesList[2].id,
  ],
);

Future<void> setPrefTheme(String themeChoice) async {

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('theme', themeChoice);

}

Future<ThemeMode> getPrefThemeMode() async {

  final prefs = await SharedPreferences.getInstance();
  String? themeChoice = prefs.getString('theme');

  if (themeChoice == null) {
    return ThemeMode.system;
  }

  switch(themeChoice) {

    case 'Dark': {
      return ThemeMode.dark;
    }

    case 'Light': {
      return ThemeMode.light;
    }

    default: {
      return ThemeMode.system;
    }

  }

}