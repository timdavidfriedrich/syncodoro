import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/core/firebase/firebase.dart';

class CountdownProvider extends ChangeNotifier {
  String clock = "00:00";
  Timer? timer;
  double percentage = 0.0;

  String status = "stop";
  int timeStarted = 0;
  int pTime = 25;
  int bTime = 5;

  void updateData(String _status, int _timeStarted, int _pTime, int _bTime) {
    status = _status;
    timeStarted = _timeStarted;
    pTime = _pTime;
    bTime = _bTime;
    notifyListeners();
  }

  String getStatus() {
    switch (status) {
      case "work":
        return "ARBEITEN";
      case "break":
        return "PAUSE";
      case "stop":
        return "[auswählen]";
      default:
        return "Status-Error!";
    }
  }

  start(context, DateTime date) {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final DateTime now = DateTime.now();
      int difference = date.difference(now).inSeconds;

      String min = (difference ~/ 60).toString().padLeft(2, "0");
      String sec = (difference % 60).toString().padLeft(2, "0");

      if (difference <= 0) stop(context);
      clock = min + ":" + sec;
      percentage = 1 - (difference / (pTime * 60));

      notifyListeners();
    });

    Provider.of<DatabaseProvider>(context, listen: false)
        .setStatus("work", date.millisecondsSinceEpoch);
    Provider.of<DatabaseProvider>(context, listen: false).setSettings(25, 5);
  }

  stop(context) {
    timer!.cancel();
    //Provider.of<DatabaseProvider>(context, listen: false).setStatus("stop", 0);
    percentage = 0;

    notifyListeners();
  }
}
