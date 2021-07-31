import 'package:flutter/material.dart';

import 'package:csc4360/widgets/custom_scaffold.dart';
import 'package:csc4360/data/service.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360/widgets/create_report.dart';
import 'package:csc4360/widgets/user_report_card.dart';

class DetailedStatus extends StatefulWidget {
  @override
  _DetailedStatusState createState() => _DetailedStatusState();
}

class _DetailedStatusState extends State<DetailedStatus> {

  late final Service service;

  @override
  Widget build(BuildContext context) {

    var routingData = getRoutingData(context);

    service = routingData['service'];

    ServiceDB db = ServiceDB(service.id);

    return CustomScaffold(
      title: service.displayName,
      contents: ListView(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  itemCount: service.uriList.length,
                  itemBuilder: (_, int index) {
                    return ValueListenableBuilder(
                      valueListenable: service.notifier,
                      builder: (_, __, ___) {

                        List<CheckStatus> results = service.checkResults;
                        CheckStatus thisResult = results[index];

                        String text = '${service.uriList[index]} check passed';
                        Color textColor = Colors.green;

                        if (thisResult == CheckStatus.IN_PROGRESS) {
                          text = 'Checking ${service.uriList[index]}...';
                          textColor = Theme.of(context).disabledColor;

                        } else if (thisResult == CheckStatus.FAILED) {
                          text = '${service.uriList[index]} check failed';
                          textColor = Colors.red;

                        } else if (thisResult == CheckStatus.TIMED_OUT) {
                          text = 'Connection to ${service.uriList[index]} timed out';
                          textColor = Colors.orange;

                        }

                        return Text(
                          text,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: textColor,
                          ),
                        );
                      }
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/services/${service.id}-logo.png',
                  width: 64,
                  height: 64
                ),
              ),
            ],
          ),
          Divider(
            indent: 20,
            thickness: 4,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'User Reports',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  child: Text('Submit Report'),
                  onPressed: () {
                    createReport(context, db);
                  },
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: db.userReportsStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot document = snapshot.data!.docs[index];
                    return UserReportCard(db, snapshot.data!.docs[index]);
                  }
                );
              } else {
                return Text('Loading...');
              }
            }
          ),
        ],
      ),
    );
  }

}
