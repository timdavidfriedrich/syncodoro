import 'package:flutter/material.dart';
import 'package:syncodoro/config/themes/color_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool workColorTileExpanded = false;
  bool breakColorTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Einstellungen")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Farbe Arbeit"),
            onTap: () =>
                setState(() => workColorTileExpanded = !workColorTileExpanded),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: workColorTileExpanded
                  ? Icon(Icons.keyboard_arrow_up_outlined,
                      color: Theme.of(context).colorScheme.onPrimary)
                  : Icon(Icons.keyboard_arrow_down_outlined,
                      color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: workColorTileExpanded ? 80 : 0,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Provider.of<ColorProvider>(context)
                    .secondaryColorList
                    .length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount:
                  Provider.of<ColorProvider>(context).secondaryColorList.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: Color(Provider.of<ColorProvider>(context)
                          .secondaryColorList[index]),
                      child: InkWell(
                        child: Color(Provider.of<ColorProvider>(context)
                                    .secondaryColorList[index]) ==
                                Theme.of(context).colorScheme.secondary
                            ? const Icon(Icons.done_rounded)
                            : Container(),
                        onTap: () {
                          Provider.of<ColorProvider>(context, listen: false)
                              .setSecondaryColor(Provider.of<ColorProvider>(
                                      context,
                                      listen: false)
                                  .secondaryColorList[index]);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: const Text("Farbe Pause"),
            onTap: () => setState(
                () => breakColorTileExpanded = !breakColorTileExpanded),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: breakColorTileExpanded
                  ? Icon(Icons.keyboard_arrow_up_outlined,
                      color: Theme.of(context).colorScheme.onPrimary)
                  : Icon(Icons.keyboard_arrow_down_outlined,
                      color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: breakColorTileExpanded ? 80 : 0,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Provider.of<ColorProvider>(context)
                    .secondaryColorList
                    .length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount:
                  Provider.of<ColorProvider>(context).secondaryColorList.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: Color(Provider.of<ColorProvider>(context)
                          .secondaryColorList[index]),
                      child: InkWell(
                        child: Color(Provider.of<ColorProvider>(context)
                                    .secondaryColorList[index]) ==
                                Theme.of(context).colorScheme.secondary
                            ? const Icon(Icons.done_rounded)
                            : Container(),
                        onTap: () {
                          Provider.of<ColorProvider>(context, listen: false)
                              .setSecondaryColor(Provider.of<ColorProvider>(
                                      context,
                                      listen: false)
                                  .secondaryColorList[index]);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // SwitchListTile(
          //   title: Text("Chat einblenden"),
          //   subtitle: Text("Viel zu hoher Online-Traffic"),
          //   value: Provider.of<DisplayProvider>(context).displayChat,
          //   onChanged: (value) =>
          //       Provider.of<DisplayProvider>(context, listen: false).swapChat(),
          // ),
        ],
      ),
    );
  }
}
