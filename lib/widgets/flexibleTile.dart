import 'package:flutter/material.dart';

class FlexibleTile extends StatefulWidget {
  final String title;
  final Widget content;
  final Color? color;
  const FlexibleTile(
      {Key? key, required this.title, required this.content, this.color})
      : super(key: key);

  @override
  State<FlexibleTile> createState() => _FlexibleTileState();
}

class _FlexibleTileState extends State<FlexibleTile> {
  bool expanded = false;

  Color processColor() {
    if (widget.color == null) {
      return Theme.of(context).colorScheme.surface;
    } else {
      return widget.color!;
    }
  }

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(widget.title),
          onTap: () => setState(() => expanded = !expanded),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: expanded
                ? Icon(Icons.keyboard_arrow_up_outlined, color: cs.onPrimary)
                : Icon(Icons.keyboard_arrow_down_outlined, color: cs.onPrimary),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: expanded ? 80 : 0,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: processColor(),
          child: widget.content,
        ),
      ],
    );
  }
}
