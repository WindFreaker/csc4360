import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:csc4360/wrappers/auth_wrapper.dart';

class ServiceDB {

  // firestore collection reference(s) for this class
  static var _userReportsRef = FirebaseFirestore.instance.collection('project2-services');

  String _serviceID;

  ServiceDB(this._serviceID);

  Stream<QuerySnapshot> get userReportsStream {
    return _userReportsRef.doc(_serviceID).collection('user-reports')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots();
  }

  Future<void> submitUserReport(String text) async {
    await _userReportsRef.doc(_serviceID).collection('user-reports').add({
      'content': text,
      'timestamp': Timestamp.now(),
      'up-voted': [AuthWrapper.selfUID],
      'down-voted': [],
    });
  }

  Future<void> voteOnUserReport(String report, bool voteType) async {
    await _userReportsRef.doc(_serviceID).collection('user-reports').doc(report).update({
      (voteType ? 'up-voted' : 'down-voted'): FieldValue.arrayUnion([AuthWrapper.selfUID]),
      (voteType ? 'down-voted' : 'up-voted'): FieldValue.arrayRemove([AuthWrapper.selfUID]),
    });
  }

}
