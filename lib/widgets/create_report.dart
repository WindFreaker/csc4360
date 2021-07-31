import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/firestore_wrapper.dart';

void createReport(BuildContext context, ServiceDB db) {

  String reportText = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Write a report'),
        content: TextField(
          onChanged: (String? value) {
            reportText = value ?? '';
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () async {
              await db.submitUserReport(reportText);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );

}