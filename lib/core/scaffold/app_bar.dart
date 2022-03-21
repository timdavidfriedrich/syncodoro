import 'package:flutter/material.dart';
import 'package:syncodoro/screens/settings.dart';
import 'package:syncodoro/screens/statistics.dart';

import 'package:syncodoro/utils/teleport.dart';

class ScaffoldAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ScaffoldAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  _ScaffoldAppBarState createState() => _ScaffoldAppBarState();
}

class _ScaffoldAppBarState extends State<ScaffoldAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.bar_chart_outlined),
        onPressed: () => Navigator.push(context,
            Teleport(child: const Statistics(), type: "scale_topLeft")),
      ),
      title: const Text("Syncodoro"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(
                context, Teleport(child: Settings(), type: "scale_topRight")),
          ),
        ),
      ],
    );
  }
}
