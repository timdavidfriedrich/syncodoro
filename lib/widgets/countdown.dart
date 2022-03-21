import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Countdown extends StatefulWidget {
  final int time;
  const Countdown({Key? key, required this.time}) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<CountdownProvider>(context).clock,
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

class CountdownProvider extends ChangeNotifier {
  String clock = "00:00";
  Timer? timer;

  // Future<void> initColors() async {
  //   prefs = await SharedPreferences.getInstance();
  //   secondaryColorCode = prefs.getInt("secondaryColor") ?? 0xff4CAF50;
  //   secondaryColor = Color(secondaryColorCode);
  //   notifyListeners();
  // }

  start(DateTime date) {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final DateTime now = DateTime.now();
      int difference = date.difference(now).inSeconds;
      String min = (difference ~/ 60).toString().padLeft(2, "0");
      String sec = (difference % 60).toString().padLeft(2, "0");
      if (difference <= 0) stop();
      clock = min + ":" + sec;
      notifyListeners();
    });
  }

  stop() {
    timer!.cancel();
  }
}

class TimeProvider extends ChangeNotifier {}
