import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:csc4360/wrappers/auth_wrapper.dart';

class UserProfile {

  // firestore collection reference(s) for this class
  static var _usersRef = FirebaseFirestore.instance.collection('user-profiles');

  // required variables
  String _userID;

  // variables for profile data and its handling
  _profileDataState _state = _profileDataState.NOT_CHECKED;
  late String _displayName;

  UserProfile(this._userID);

  Future<void> createNew({required String displayName}) async {

    final doc = await _usersRef.doc(_userID).get();

    if (!doc.exists) {
      await _usersRef.doc(_userID).set({
        'displayName': displayName,
        'registeredAt': Timestamp.now(),
      });
    }

    // yeah good luck ever doing this on accident lmao
    throw Exception('The UserProfile already has data. Has createNew already been run?');

  }

  Future<String?> get displayName async {

    // if the firebase doc has not been read yet...
    if (_state == _profileDataState.NOT_CHECKED) {
      await _getData();  // ...do the downloading/reading bit
    }
    // depending on if the data is properly set...
    if (_state == _profileDataState.DATA_SET) {
      return _displayName;  // ...get the username variable
    } else {
      return null;  // ...or return null
    }

  }

  Future<void> _getData() async {

    await _usersRef.doc(_userID).get().then((DocumentSnapshot document) {
      if (document.exists) {

        var data = document.data() as Map<String, dynamic>;
        _displayName = data['displayName'];

        _state = _profileDataState.DATA_SET;

      } else {

        print('wow, this should not be possible');
        print('trying to get data for a user that has not been created yet?');

        _state = _profileDataState.DOES_NOT_EXIST;

      }
    });

  }

  Future<void> modify({String? displayName}) async {
    Map<String, dynamic> newData = {};

    if (displayName != null) {
      newData['displayName'] = displayName;
    }

    await _usersRef.doc(_userID).set(newData, SetOptions(merge: true));
  }

}

enum _profileDataState {
  NOT_CHECKED,
  DATA_SET,
  DOES_NOT_EXIST,
}

class MessageBoard {

  // firestore collection reference(s) for this class
  static var _msgBoardsRef = FirebaseFirestore.instance.collection('project1-boards');

  // required variables
  String _boardID;

  MessageBoard(this._boardID);

  static Stream<QuerySnapshot> get listStream {
    return _msgBoardsRef.orderBy('latest_timestamp', descending: true).snapshots();
  }

  Stream<QuerySnapshot> get messageStream {
    return _msgBoardsRef.doc(_boardID).collection(_boardID)
        .orderBy('timestamp', descending: true)
        .limit(30)
        .snapshots();
  }

  Future<void> sendMessage(String message) async {

    var messageAt = Timestamp.now();

    await _msgBoardsRef.doc(_boardID).collection(_boardID).add({
      'message': message,
      'timestamp': messageAt,
      'authorID': AuthWrapper.selfUID,
    });

    await _msgBoardsRef.doc(_boardID).set({
      'latest_message': message,
      'latest_timestamp': messageAt,
    }, SetOptions(merge: true));

  }

}
