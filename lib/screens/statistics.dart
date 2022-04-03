import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistik")),
      body: const Center(
          child: Text("Coming soon.\n\nTODO:" +
              "\n- Akzentfarbe Arbeit/Pause" +
              "\n- Login via Email" +
              "\n- Statistik" +
              "\n- ...")),
    );
  }
}
