import 'package:flutter/material.dart';
import 'package:syncodoro/utils/providers/color_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncodoro/utils/providers/database_provider.dart';
import 'package:syncodoro/utils/providers/google_provider.dart';
import 'package:syncodoro/widgets/flexibleTile.dart';

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
          FlexibleTile(
            title: "Farbe Arbeit",
            content: GridView.builder(
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
          FlexibleTile(
            title: "Farbe Pause",
            content: GridView.builder(
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
          )
        ],
      ),
    );
  }
}
