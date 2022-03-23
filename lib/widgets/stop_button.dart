import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/utils/providers/countdown_provider.dart';

class StopButton extends StatefulWidget {
  const StopButton({Key? key}) : super(key: key);

  @override
  State<StopButton> createState() => _StopButtonState();
}

class _StopButtonState extends State<StopButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.stop_outlined),
      iconSize: 72,
      onPressed: () =>
          Provider.of<CountdownProvider>(context, listen: false).stop(context),
    );
  }
}
