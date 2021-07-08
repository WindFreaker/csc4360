import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360/wrappers/auth_wrapper.dart';
import 'package:csc4360/wrappers/firestore_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:csc4360/wrappers/navigation_wrapper.dart';
import 'package:csc4360/wrappers/ad_wrapper.dart';

class ChatMessages extends StatefulWidget {
  final Stream<QuerySnapshot> stream;

  ChatMessages({required this.stream});

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {

  Map<String, String?> displayNameList = {};

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder(
        stream: widget.stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder(
              future: getDisplayNames(snapshot.data!),
              builder: (BuildContext context, _) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return messageWidget(snapshot.data!.docs[index]);
                  },
                  itemCount: snapshot.data!.docs.length,
                  reverse: true,
                );
              }
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<void> getDisplayNames(QuerySnapshot data) async {
    for (QueryDocumentSnapshot document in data.docs) {

      if (displayNameList.containsKey(document['authorID'])) {
        continue;
      } else {
        displayNameList[document['authorID']] = await UserProfile(document['authorID']).displayName;
      }

    }

  }

  Widget messageWidget(QueryDocumentSnapshot document) {

    // variables used for displaying info
    bool selfAuthor = (document['authorID'] == AuthWrapper.selfUID);
    String msgText = document['message'];
    String msgTimestamp = DateFormat('HH:mm').format((document['timestamp'] as Timestamp).toDate());
    late String displayName;

    // if the list of known names contains a entry for the message's author ID...
    if (displayNameList.containsKey(document['authorID'])) {

      // ...retrieve that entry
      String? listResult = displayNameList[document['authorID']];

      // and depending on if its a valid String or not...
      if (listResult != null) {
        displayName = listResult;  // ..either display the name
      } else {
        displayName = document['authorID'];  // ...or display the author's ID, as a debug effort
      }

    } else {  // and when the list doesn't contain an entry yet, show "Loading..." so the app user knows to wait
      displayName = 'Loading...';
    }

    // now build that message UI element!
    return Card(
      margin: EdgeInsets.fromLTRB(selfAuthor ? 70 : 10, 0, selfAuthor ? 10 : 70, 10),
      shape: null,
      child: ListTile(
        title: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                displayName,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                msgTimestamp,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(
          msgText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );

  }

}

class ChatInput extends StatefulWidget {

  final String chatID;

  ChatInput({required this.chatID});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  var _ctrlInput = TextEditingController();

  RewardedAd? _rewardedAd;
  bool _adReady = false;

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdWrapper.rewardedAdUnitID,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (_) {
              setState(() {
                _adReady = false;
              });
              _loadRewardedAd();
            }
          );
          setState(() {
            _adReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _adReady = false;
          });
        }
      ),
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!_adReady) _loadRewardedAd();

    if (AuthWrapper.anonymous) {
      return Card(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        color: Theme.of(context).primaryColor,
        child: ListTile(
          leading: Icon(
            Icons.message,
            color: Colors.white,
          ),
          title: Text(
            'Sign in to send messages',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: () {
            ChangeRoute(context, '/new_user').addOnTop();
          },
        ),
      );
    }

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
          icon: Icon(_adReady ? Icons.send : Icons.lock),
          onPressed: () async {
            if (_ctrlInput.text != '' && _adReady) {
              _rewardedAd!.show(
                onUserEarnedReward: (_, __) {},  // user gets nothing >:)
              );
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

