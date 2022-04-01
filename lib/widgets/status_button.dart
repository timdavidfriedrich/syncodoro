import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/utils/providers/countdown_provider.dart';
import 'package:syncodoro/utils/providers/database_provider.dart';

class StatusButton extends StatefulWidget {
  const StatusButton({Key? key}) : super(key: key);

  @override
  State<StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends State<StatusButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(Provider.of<CountdownProvider>(context).processType()),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    //title: const Text("Auswählen"),
                    titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    contentPadding: const EdgeInsets.all(0),
                    content: Column(mainAxisSize: MainAxisSize.min, children: [
                      ListTile(
                        title: const Text(
                          "Arbeiten",
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Provider.of<DatabaseProvider>(context, listen: false)
                              .setType("pomodoro");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text(
                          "Kurze Pause",
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Provider.of<DatabaseProvider>(context, listen: false)
                              .setType("short break");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text(
                          "Lange Pause",
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Provider.of<DatabaseProvider>(context, listen: false)
                              .setType("long break");
                          Navigator.pop(context);
                        },
                      )
                    ]),
                  ));
        });
  }
}
