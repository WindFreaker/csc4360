import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class Service {

  final String id;
  final String displayName;
  final List<Uri> uriList;
  List<CheckStatus> checkResults = [];
  late ValueNotifier<bool> notifier;

  Service({
    required this.id,
    required this.displayName,
    required this.uriList,
  }) {
    checkResults = List<CheckStatus>.filled(uriList.length, CheckStatus.UNCHECKED);
    notifier = ValueNotifier<bool>(false);
  }

  void startChecks() {
    checkResults = List<CheckStatus>.filled(uriList.length, CheckStatus.IN_PROGRESS);
    _checkLoop();
  }

  Future _checkLoop() async {
    for (var index = 0; index < uriList.length; index++) {

      print('Performing check for ${uriList[index]}...');

      CheckStatus results = CheckStatus.FAILED;

      try {

        var response = await http.get(uriList[index]).timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          results = CheckStatus.ALL_GOOD;
        }

      } on TimeoutException catch (_) {

        // happens when the request takes more than the timeout duration
        results = CheckStatus.TIMED_OUT;

      } on SocketException catch (_) {

        // something to do with the Uri being wrong?

      } catch (e) {

        // this breaks things! print it out
        print('Unknown Error!');
        print(e);

      }

      checkResults[index] = results;
      notifier.value = !notifier.value;
    }
  }

}

enum CheckStatus {
  UNCHECKED,
  IN_PROGRESS,
  ALL_GOOD,
  TIMED_OUT,
  FAILED,
}