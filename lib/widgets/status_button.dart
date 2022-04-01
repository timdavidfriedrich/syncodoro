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
                    title: Text("Wähle..."),
                    content: Column(children: [
                      TextButton(
                        child: Text("Arbeiten"),
                        onPressed: () {
                          Provider.of<DatabaseProvider>(context, listen: false)
                              .setType("pomodoro");
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text("Kurze Pause"),
                        onPressed: () {
                          Provider.of<DatabaseProvider>(context, listen: false)
                              .setType("short break");
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text("Lange Pause"),
                        onPressed: () {
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
