import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;
  final Widget? desktop;
  const Responsive(
      {Key? key, required this.portrait, required this.landscape, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //if (constraints.maxWidth < 480) {
        if (desktop != null && constraints.maxWidth > 800) {
          return desktop!;
        } else if (MediaQuery.of(context).orientation == Orientation.portrait) {
          return portrait;
        } else {
          return landscape;
        }
      },
    );
  }
}
