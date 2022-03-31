import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncodoro/config/themes/color_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncodoro/core/firebase/firebase.dart';

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
    var cp = Provider.of<ColorProvider>(context);
    var cpf = Provider.of<ColorProvider>(context, listen: false);
    var cs = Theme.of(context).colorScheme;
    var tt = Theme.of(context).textTheme;
    final u = Provider.of<DatabaseProvider>(context).user;
    return Scaffold(
      appBar: AppBar(title: const Text("Einstellungen")),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: cs.onPrimary, width: 4)),
            margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            padding: const EdgeInsets.all(4),
            child: Container(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 24),
              color: cs.secondary,
              child: Row(
                children: [
                  Flexible(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: cs.onPrimary,
                      backgroundImage: NetworkImage(u.photoURL!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(u.displayName!,
                          style: tt.displayMedium!
                              .copyWith(color: cs.onSecondary)),
                      Text(u.email!,
                          style:
                              tt.displaySmall!.copyWith(color: cs.onSecondary)),
                      ElevatedButton(
                        child: Text(
                          "Account wechseln",
                          textAlign: TextAlign.center,
                          style: tt.labelSmall,
                        ),
                        onPressed: () =>
                            Provider.of<GoogleProvider>(context, listen: false)
                                .googleLogout(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Farbe Arbeit"),
            onTap: () =>
                setState(() => workColorTileExpanded = !workColorTileExpanded),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: workColorTileExpanded
                  ? Icon(Icons.keyboard_arrow_up_outlined, color: cs.onPrimary)
                  : Icon(Icons.keyboard_arrow_down_outlined,
                      color: cs.onPrimary),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: workColorTileExpanded ? 80 : 0,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: cs.surface,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cp.secondaryColorList.length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: cp.secondaryColorList.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: Color(cp.secondaryColorList[index]),
                      child: InkWell(
                        child:
                            Color(cp.secondaryColorList[index]) == cs.secondary
                                ? const Icon(Icons.done_rounded)
                                : Container(),
                        onTap: () {
                          cpf.setSecondaryColor(cpf.secondaryColorList[index]);
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
                  ? Icon(Icons.keyboard_arrow_up_outlined, color: cs.onPrimary)
                  : Icon(Icons.keyboard_arrow_down_outlined,
                      color: cs.onPrimary),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: breakColorTileExpanded ? 80 : 0,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: cs.surface,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cp.secondaryColorList.length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: cp.secondaryColorList.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Material(
                      color: Color(cp.secondaryColorList[index]),
                      child: InkWell(
                        child:
                            Color(cp.secondaryColorList[index]) == cs.secondary
                                ? const Icon(Icons.done_rounded)
                                : Container(),
                        onTap: () {
                          cpf.setSecondaryColor(cpf.secondaryColorList[index]);
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
