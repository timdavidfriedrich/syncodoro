import 'package:flutter/material.dart';

import 'package:syncodoro/widgets/bar.dart';
import 'package:syncodoro/widgets/countdown.dart';
import 'package:syncodoro/widgets/play_pause_button.dart';
import 'package:syncodoro/widgets/status_button.dart';
import 'package:syncodoro/widgets/stop_button.dart';

class HomeDesktop extends StatefulWidget {
  const HomeDesktop({Key? key}) : super(key: key);

  @override
  State<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends State<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const StatusButton(),
          const Countdown(),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Bar(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [PlayPauseButton(), StopButton()],
            ),
          )
        ],
      ),
    );
  }
}
