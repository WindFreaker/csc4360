import 'package:flutter/material.dart';

import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:csc4360/widgets/chat_widgets.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';

class OpenChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    late String _chatTitle, _chatID;

    var data = getRoutingData(context);

    _chatID = data['id'];
    _chatTitle = data['title'];

    return Scaffold(
      appBar: AppBar(
        title: Text(_chatTitle),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              ChatMessages(
                stream: MessageBoard(_chatID).messageStream(),
              ),
              ChatInput(
                chatID: _chatID,
              ),
            ],
          ),
        ],
      ),
    );

  }
}


