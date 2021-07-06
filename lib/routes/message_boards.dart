import 'package:flutter/material.dart';

import 'package:csc4360/widgets/nav_scaffold.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';

class MessageBoards extends StatefulWidget {
  @override
  _MessageBoardsState createState() => _MessageBoardsState();
}

class _MessageBoardsState extends State<MessageBoards> {
  @override
  Widget build(BuildContext context) {
    return NavigationScaffold(
      title: 'Message Boards',
      body: StreamBuilder(
        stream: MessageBoard.listStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Card(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Image.network(data['icon_url']),
                  title: Text(data['title'] as String),
                  subtitle: Text(
                    data['latest_message'],
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    ChangeRoute(context, '/open_chat').withData({
                      'id': document.id,
                      'title': data['title'],
                    }).addOnTop();
                  },
                ),
              );
            }).toList(),
          );
        }
      ),
    );
  }
}
