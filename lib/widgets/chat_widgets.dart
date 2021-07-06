import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';
import 'package:flutter/cupertino.dart';

class ChatMessages extends StatelessWidget {

  final Stream<QuerySnapshot> stream;

  ChatMessages({required this.stream});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return messageWidget(snapshot.data!.docs[index]);
              },
              itemCount: snapshot.data!.docs.length,
              reverse: true,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget messageWidget(QueryDocumentSnapshot document) {

  bool selfAuthor = (document['authorID'] == getUserID());

  // TODO: change this to show display name not id
  String displayName = document['authorID'];

  /**
  var profile = UserProfile(document['authorID']).get();
  if (profile != null && profile['displayName'] != '') {
    displayName = profile['displayName'];
  }
      **/

  return Card(
    margin: EdgeInsets.fromLTRB(selfAuthor ? 70 : 10, 0, selfAuthor ? 10 : 70, 10),
    shape: null,
    child: ListTile(
      title: Text(displayName),
      subtitle: Text(document['message']),
    ),
  );

}

class ChatInput extends StatefulWidget {

  final String chatID;

  ChatInput({required this.chatID});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  var _ctrlInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            child: TextField(
              autofocus: true,
              maxLines: 3,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type your message here...',
              ),
              controller: _ctrlInput,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () async {
            if (_ctrlInput.text != '') {
              String message = _ctrlInput.text;
              _ctrlInput.text = '';
              await MessageBoard(widget.chatID).sendMessage(message);
            }
          },
        ),
      ],
    );
  }
}

