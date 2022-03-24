import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/core/firebase/firebase.dart';
import 'package:syncodoro/utils/console.dart';

class CountdownProvider extends ChangeNotifier {
  String clock = "00:00";
  Timer? timer;
  double percentage = 0.0;

  String type = "none";
  String status = "stop";
  int time = 0;
  int pTime = 25;
  int bTime = 5;

  void updateData(
      String _type, String _status, int _time, int _pTime, int _bTime) {
    type = _type;
    status = _status;
    time = _time;
    pTime = _pTime;
    bTime = _bTime;
    notifyListeners();
  }

  String processType() {
    switch (type) {
      case "pomodoro":
        return "ARBEITEN";
      case "break":
        return "PAUSE";
      case "none":
        return "[auswählen]";
      default:
        return "Status-Error!";
    }
  }

  int getTime() {
    switch (type) {
      case "pomodoro":
        return pTime;
      case "break":
        return bTime;
      default:
        return 0;
    }
  }

  runTimer(context, date) {
    if (timer != null) timer!.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final DateTime now = DateTime.now();
      int difference = date.difference(now).inSeconds;
      printHint("$difference | ${difference ~/ 60}");
      String min = (difference ~/ 60).toString().padLeft(2, "0");
      String sec = (difference % 60).toString().padLeft(2, "0");

      if (difference <= 0) stop(context);
      clock = min + ":" + sec;
      percentage = 1 - (difference / (pTime * 60));

      notifyListeners();
    });
  }

  play(context, String _type) {
    type = _type;
    if (status == "pause") {
      DateTime _time = DateTime.fromMillisecondsSinceEpoch(time);
      DateTime date = DateTime.now().add(_time.difference(DateTime.now()));
      //time = date.millisecondsSinceEpoch;
      printHint("time (3): $time");
      runTimer(context, date);
    } else {
      printHint("time (1): $time");
      DateTime date = DateTime.now().add(Duration(minutes: getTime()));
      time = date.millisecondsSinceEpoch;
      printHint("time (2): $time");

      runTimer(context, date);
    }

    Provider.of<DatabaseProvider>(context, listen: false)
        .setStatus(type, "play", time);
    Provider.of<DatabaseProvider>(context, listen: false).setSettings(25, 5);

    notifyListeners();
  }

  resume(context) {
    DateTime date = DateTime.now().add(Duration(minutes: getTime()));
    runTimer(context, date);
  }

  pause(context) {
    if (timer != null) timer!.cancel();
    DateTime _time = DateTime.fromMillisecondsSinceEpoch(time);
    Provider.of<DatabaseProvider>(context, listen: false).setStatus(
        type, "pause", _time.difference(DateTime.now()).inMilliseconds);
  }

  stop(context) {
    if (timer != null) timer!.cancel();
    Provider.of<DatabaseProvider>(context, listen: false)
        .setStatus("none", "stop", 0);
    percentage = 0;
    clock = "00:00";

    notifyListeners();
  }
}
