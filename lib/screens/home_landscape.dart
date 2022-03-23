import 'package:flutter/material.dart';

import 'package:syncodoro/widgets/bar.dart';
import 'package:syncodoro/widgets/countdown.dart';
import 'package:syncodoro/widgets/play_pause_button.dart';
import 'package:syncodoro/widgets/status_button.dart';
import 'package:syncodoro/widgets/stop_button.dart';

class HomeLandscape extends StatefulWidget {
  const HomeLandscape({Key? key}) : super(key: key);

  @override
  State<HomeLandscape> createState() => _HomeLandscapeState();
}

class _HomeLandscapeState extends State<HomeLandscape> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("landscape"));
  }
}
