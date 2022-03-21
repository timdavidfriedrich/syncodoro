import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget portraitLayout;
  final Widget landscapeLayout;
  const Responsive(
      {Key? key, required this.portraitLayout, required this.landscapeLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 480) {
          return portraitLayout;
        } else {
          return landscapeLayout;
        }
      },
    );
  }
}
