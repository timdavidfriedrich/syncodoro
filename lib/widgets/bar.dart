import 'package:flutter/material.dart';

class Bar extends StatefulWidget {
  const Bar({Key? key}) : super(key: key);

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onPrimary, width: 4)),
      margin: const EdgeInsets.fromLTRB(80, 18, 80, 0),
      padding: const EdgeInsets.all(4),
      // TODO: Bar-Animation
      child: Container(color: Theme.of(context).colorScheme.secondary),
    );
  }
}
