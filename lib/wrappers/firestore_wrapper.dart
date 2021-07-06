import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:csc4360/wrappers/auth_wrapper.dart';

class UserProfile {

  // firestore collection reference(s) for this class
  static var _usersRef = FirebaseFirestore.instance.collection('user-profiles');

  // required variables
  String _userID;

  UserProfile(this._userID);

  Future<void> create({required String displayName}) async {

    await _usersRef.doc(_userID).set({
      'displayName': displayName,
      'registeredAt': Timestamp.now(),
    });

  }

  Future<Map<String, dynamic>?> get() async {

    return await _usersRef.doc(_userID).get().then((DocumentSnapshot document) {
      if (document.exists) {
        return document.data() as Map<String, dynamic>;
      } else {
        return null;
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

class MessageBoard {

  // firestore collection reference(s) for this class
  static var _msgBoardsRef = FirebaseFirestore.instance.collection('project1-boards');

  // required variables
  String _boardID;

  MessageBoard(this._boardID);

  Stream<QuerySnapshot> messageStream() {
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
      'authorID': getUserID(),
    });

    await _msgBoardsRef.doc(_boardID).set({
      'latest_message': message,
      'latest_timestamp': messageAt,
    }, SetOptions(merge: true));

  }

  static Stream<QuerySnapshot> listStream() {
    return _msgBoardsRef.orderBy('latest_timestamp', descending: true).snapshots();
  }

}

/**
 *
String combineTwoIDs(String userOne, String userTwo) {
  print(userOne);
  print(userTwo);
  return userOne.hashCode <= userTwo.hashCode ? userOne + '_' + userTwo : userTwo + '_' + userOne;
}

Stream<QuerySnapshot> contactsListStream() {
  return userRef.snapshots();
}

Stream<QuerySnapshot> chatsListStream() {
  return convRef.where('members', arrayContains: AuthWrapper.getUserID()).snapshots();
}

Stream<QuerySnapshot> conversationStream(String conversationID) {
  return convRef.doc(conversationID).collection(conversationID)
      .orderBy('timestamp', descending: true)
      .limit(20)
      .snapshots();
}

Future<void> addMessageToConversation(String conversationID, String message) async {
  await convRef.doc(conversationID).collection(conversationID).add({
    'message': message,
    'fromID': AuthWrapper.getUserID(),
    'timestamp': Timestamp.now(),
  });
}

**/
