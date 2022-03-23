import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/constants/app_constants.dart';
import 'package:syncodoro/utils/providers/countdown_provider.dart';
import 'package:syncodoro/widgets/bar.dart';
import 'package:syncodoro/widgets/countdown.dart';
import 'package:syncodoro/widgets/play_pause_button.dart';
import 'package:syncodoro/widgets/status_button.dart';
import 'package:syncodoro/widgets/stop_button.dart';

class HomePortrait extends StatefulWidget {
  const HomePortrait({Key? key}) : super(key: key);

  @override
  State<HomePortrait> createState() => _HomePortraitState();
}

class _HomePortraitState extends State<HomePortrait> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StatusButton(),
          Countdown(),
          Bar(),
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
