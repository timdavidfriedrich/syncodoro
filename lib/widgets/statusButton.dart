import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/widgets/countdown.dart';

class StatusButton extends StatefulWidget {
  const StatusButton({Key? key}) : super(key: key);

  @override
  State<StatusButton> createState() => _StatusButtonState();
}

class _StatusButtonState extends State<StatusButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(Provider.of<CountdownProvider>(context).getStatus()),
        onPressed: () {});
  }
}
