import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/utils/providers/countdown_provider.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({Key? key}) : super(key: key);

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  String processType() {
    String _type = Provider.of<CountdownProvider>(context, listen: false).type;
    if (_type == "none") return "pomodoro";
    return _type;
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<CountdownProvider>(context).status != "play"
        ? IconButton(
            icon: const Icon(Icons.play_arrow_outlined),
            iconSize: 72,
            onPressed: () {
              Provider.of<CountdownProvider>(context, listen: false)
                  .play(context, processType());
            },
          )
        : IconButton(
            icon: const Icon(Icons.pause_outlined),
            iconSize: 64,
            onPressed: () =>
                Provider.of<CountdownProvider>(context, listen: false)
                    .pause(context),
          );
  }
}
