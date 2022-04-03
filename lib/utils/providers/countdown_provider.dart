import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncodoro/constants/app_constants.dart';

import 'package:syncodoro/utils/console.dart';
import 'package:syncodoro/utils/providers/database_provider.dart';

//! Zeitenanzeige (bei Pause?) verbuggt.
//! Zeigt falsche Zeit an, die bei erneuten Play wieder korrigiert wird.

class CountdownProvider extends ChangeNotifier {
  String clock = "00:00";
  Timer? timer;
  double percentage = 0.0;

  String type = defaultType;
  String status = defaultStatus;
  int started = defaultStarted;
  int remain = defaultRemain;
  int pTime = defaultPomodoro;
  int lbTime = defaultLBreak;
  int sbTime = defaultSBreak;
  int count = defaultCount;
  int interval = defaultInterval;
  bool auto = defaultAuto;

  void updateData(
      String _type,
      String _status,
      int _started,
      int _remain,
      int _pTime,
      int _lbTime,
      int _sbTime,
      int _count,
      int _interval,
      bool _auto) {
    type = _type;
    status = _status;
    started = _started;
    remain = _remain;
    pTime = _pTime;
    lbTime = _lbTime;
    sbTime = _sbTime;
    count = _count;
    interval = _interval;
    auto = _auto;
    notifyListeners();
  }

  String processType() {
    switch (type) {
      case "pomodoro":
        return "ARBEITEN";
      case "long break":
        return "LANGE PAUSE";
      case "short break":
        return "KURZE PAUSE";
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
      case "long break":
        return lbTime;
      case "short break":
        return sbTime;
      default:
        return 1;
    }
  }

  runTimer(BuildContext context) {
    stopTimer();
    timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      if (status == "stop") {
        percentage = 0;
        clock = "00:00";
        notifyListeners();
        return;
      } else if (status == "pause") {
        return;
      }

      final DateTime now = DateTime.now();
      int difference = now
          .difference(DateTime.fromMillisecondsSinceEpoch(started))
          .inSeconds;
      int output = remain - difference; // seconds
      printHint("$output | ${output ~/ 60}:${output % 60}");
      String min = (output ~/ 60).toString().padLeft(2, "0");
      String sec = (output % 60).toString().padLeft(2, "0");

      if (output <= 0) phaseEnd(context);

      clock = min + ":" + sec;
      percentage = 1 - (output / getTime());
      notifyListeners();
    });
  }

  stopTimer() {
    if (timer != null) timer!.cancel();
  }

  play(BuildContext context, String _type) {
    type = _type;
    started = DateTime.now().millisecondsSinceEpoch;
    if (status == "stop") remain = getTime(); // Wenn vorher Stop, Neubeginn

    notifyListeners();
    Provider.of<DatabaseProvider>(context, listen: false)
        .setPhase(type, "play", started, remain, count);
  }

  pause(BuildContext context) {
    DateTime now = DateTime.now();
    remain = remain - ((now.millisecondsSinceEpoch - started) ~/ 1000);
    printHint("remain: $remain");

    notifyListeners();
    Provider.of<DatabaseProvider>(context, listen: false).setStatus("pause");
  }

  stop(BuildContext context) {
    Provider.of<DatabaseProvider>(context, listen: false)
        .setPhase("none", "stop", 0, 0, 0);
  }

  // TODO: play sound + pushup notification
  phaseEnd(BuildContext context) {
    if (auto) {
      if (type == "pomodoro") {
        count++;
        notifyListeners();
        if ((count % interval) != 0) {
          //stop(context);
          type = "short break";
          remain = sbTime;
          notifyListeners();
          //Provider.of<DatabaseProvider>(context, listen: false).setType("short break");
          play(context, "short break");
        } else {
          //stop(context);
          type = "long break";
          remain = lbTime;
          notifyListeners();
          //Provider.of<DatabaseProvider>(context, listen: false).setType("long break");
          play(context, "long break");
        }
      } else if (type == "short break" || type == "long break") {
        //stop(context);
        type = "pomodoro";
        remain = pTime;
        notifyListeners();
        //Provider.of<DatabaseProvider>(context, listen: false).setType("pomodoro");
        play(context, "pomodoro");
      } else {
        printError("Phase not found (CountdownProvider)");
        stop(context);
      }
    } else {
      printHint("Auto. phase switch disabled => stop().");
      stop(context);
    }
  }
}
