import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';

class UserReportCard extends StatefulWidget {

  final ServiceDB _db;
  final QueryDocumentSnapshot _document;

  UserReportCard(this._db, this._document);

  @override
  _UserReportCardState createState() => _UserReportCardState();
}

class _UserReportCardState extends State<UserReportCard> {

  @override
  Widget build(BuildContext context) {

    int voteState = 0;
    if (widget._document['up-voted'].contains(AuthWrapper.selfUID)) {
      voteState = 1;
    } else if (widget._document['down-voted'].contains(AuthWrapper.selfUID)) {
      voteState = 2;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(widget._document['content']),
        subtitle: Text(DateFormat('HH:mm MMMM dd, yyyy').format(widget._document['timestamp'].toDate())),
        trailing: Wrap(
          spacing: 12,
          children: <Widget>[
            IconButton(
              splashRadius: 25,
              iconSize: 30,
              padding: const EdgeInsets.all(0),
              icon: Icon(
                Icons.arrow_upward,
                color: (voteState == 1) ? Colors.deepOrange : null,
              ),
              onPressed: () async {
                await widget._db.voteOnUserReport(widget._document.id, true);
              },
            ),
            IconButton(
              splashRadius: 25,
              iconSize: 30,
              padding: const EdgeInsets.all(0),
              icon: Icon(
                Icons.arrow_downward,
                color: (voteState == 2) ? Colors.blue : null,
              ),
              onPressed: () async {
                await widget._db.voteOnUserReport(widget._document.id, false);
              },
            ),
          ],
        ),
      ),
    );
  }

}
