import 'package:csc4360/wrappers/prefs_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:csc4360/widgets/custom_scaffold.dart';
import 'package:csc4360/widgets/settings_header.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  String themeDropdown = 'System';

  Future<void> _getTheme() async {

    ThemeMode themeChoice = await getPrefThemeMode();

    switch(themeChoice) {

      case ThemeMode.dark: {
        themeDropdown = 'Dark';
        return;
      }

      case ThemeMode.light: {
        themeDropdown = 'Light';
        return;
      }

      default: {
        themeDropdown = 'System';
        return;
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Settings',
      contents: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: AuthWrapper.anonymous ? AnonAccountHeader() : GoogleAccountHeader(),
          ),
          Divider(
            height: 0,
            thickness: 2,
          ),
          Expanded(
            flex: 6,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                FutureBuilder(
                  future: _getTheme(),
                  builder: (_, __) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Set Theme'),
                        DropdownButton(
                            value: themeDropdown,
                            items: <String>[
                              'System',
                              'Dark',
                              'Light',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) async {
                              themeDropdown = newValue!;
                              await setPrefTheme(themeDropdown);
                              setState(() {});
                            }
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
