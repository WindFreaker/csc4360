import 'package:flutter/material.dart';

import 'package:csc4360/data/service.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:flutter/cupertino.dart';

class ServiceStatusCard extends StatefulWidget {

  final Service _service;

  ServiceStatusCard(this._service);

  @override
  _ServiceStatusCardState createState() => _ServiceStatusCardState();
}

class _ServiceStatusCardState extends State<ServiceStatusCard> {

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ChangeRoute(context, '/detailed_status').withData({
            'service': widget._service,
          }).addOnTop();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    'assets/services/${widget._service.id}-logo.png',
                    width: 64,
                    height: 64,
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget._service.displayName,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        ValueListenableBuilder(
                          valueListenable: widget._service.notifier,
                          builder: (_, __, ___) {

                            List<CheckStatus> results = widget._service.checkResults;

                            if (results.contains(CheckStatus.UNCHECKED)) {
                              widget._service.startChecks();
                            }

                            String text = 'All checks passed';
                            Color textColor = Colors.green;

                            if (results.contains(CheckStatus.IN_PROGRESS)) {
                              int counter = results.length;
                              for (var index = 0; index < results.length; index++) {
                                if (results[index] == CheckStatus.IN_PROGRESS) {
                                  counter--;
                                }
                              }
                              text = 'Performing checks... (${counter + 1} of ${results.length})';
                              textColor = Theme.of(context).disabledColor;
                            } else if (results.contains(CheckStatus.FAILED)) {

                              if (results.contains(CheckStatus.ALL_GOOD)) {
                                text = 'Some checks failed';
                                textColor = Colors.orange;
                              } else {
                                text = 'All checks failed';
                                textColor = Colors.red;
                              }

                            } else if (results.contains(CheckStatus.TIMED_OUT)) {
                              text = 'Connection(s) timed out';
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
                        ),
                        Text(
                          'Tap for more details',
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'extra crazy warnings go here',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: (false) ? null : 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
