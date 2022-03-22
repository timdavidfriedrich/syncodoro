import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/constants/app_constants.dart';
import 'package:syncodoro/widgets/bar.dart';
import 'package:syncodoro/widgets/countdown.dart';

class HomeLandscape extends StatefulWidget {
  const HomeLandscape({Key? key}) : super(key: key);

  @override
  State<HomeLandscape> createState() => _HomeLandscapeState();
}

class _HomeLandscapeState extends State<HomeLandscape> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text("ARBEITEN"), // TODO: Arbeit / Pause
                  onPressed: () {},
                ),
                Countdown(time: pomodoroTime),
                Bar(),
              ],
            ),
          ),
          const SizedBox(width: 72),
          Container(
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow_outlined),
                  iconSize: 72,
                  onPressed: () =>
                      Provider.of<CountdownProvider>(context, listen: false)
                          .start(context,
                              DateTime.now().add(const Duration(minutes: 3))),
                ),
                IconButton(
                  icon: const Icon(Icons.stop_outlined),
                  iconSize: 72,
                  onPressed: () =>
                      Provider.of<CountdownProvider>(context, listen: false)
                          .stop(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
