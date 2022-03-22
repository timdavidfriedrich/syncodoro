import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/constants/app_constants.dart';
import 'package:syncodoro/core/firebase/firebase.dart';
import 'package:syncodoro/utils/console.dart';
import 'package:syncodoro/widgets/bar.dart';
import 'package:syncodoro/widgets/countdown.dart';
import 'package:syncodoro/widgets/statusButton.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Countdown(time: pomodoroTime),
          ),
          Bar(),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Row(
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
