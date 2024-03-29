import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncodoro/constants/app_constants.dart';
import 'package:syncodoro/utils/console.dart';
import 'package:syncodoro/utils/providers/color_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncodoro/utils/providers/countdown_provider.dart';
import 'package:syncodoro/utils/providers/database_provider.dart';
import 'package:syncodoro/utils/providers/google_provider.dart';
import 'package:syncodoro/utils/responsive.dart';
import 'package:syncodoro/widgets/flexibleTile.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Einstellungen")),
      body: Responsive(
        portrait: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            ProfileBox(),
            SecondaryColorSettings(),
            PhaseSwitchSettings(),
            TimeSettings(),
          ],
        ),
        landscape: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: ListView(shrinkWrap: true, children: [ProfileBox()])),
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  SecondaryColorSettings(),
                  PhaseSwitchSettings(),
                  TimeSettings(),
                ],
              ),
            ),
          ],
        ),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                child: ListView(shrinkWrap: true, children: [ProfileBox()])),
            Flexible(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  SecondaryColorSettings(),
                  PhaseSwitchSettings(),
                  TimeSettings(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBox extends StatefulWidget {
  const ProfileBox({Key? key}) : super(key: key);

  @override
  State<ProfileBox> createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    var tt = Theme.of(context).textTheme;
    final u = Provider.of<DatabaseProvider>(context).user;
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: cs.onPrimary, width: 4)),
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
                    style: tt.displayMedium!.copyWith(color: cs.onSecondary)),
                Text(u.email!,
                    style: tt.displaySmall!.copyWith(color: cs.onSecondary)),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                    child: Text(
                      "Account wechseln",
                      textAlign: TextAlign.center,
                      style: tt.labelSmall!.copyWith(color: cs.primary),
                    ),
                    style: ElevatedButton.styleFrom(primary: cs.onPrimary),
                    onPressed: () =>
                        Provider.of<GoogleProvider>(context, listen: false)
                            .googleLogout(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryColorSettings extends StatefulWidget {
  const SecondaryColorSettings({Key? key}) : super(key: key);

  @override
  State<SecondaryColorSettings> createState() => _SecondaryColorSettingsState();
}

class _SecondaryColorSettingsState extends State<SecondaryColorSettings> {
  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<ColorProvider>(context);
    var cpf = Provider.of<ColorProvider>(context, listen: false);
    var cs = Theme.of(context).colorScheme;
    return FlexibleTile(
      title: "Akzent-Farbe",
      subtitle: "HINWEIS: Wird nur lokal gespeichert.",
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
              //orderRadius: BorderRadius.circular(16),
              child: Material(
                color: Color(cp.secondaryColorList[index]),
                child: InkWell(
                  child: Color(cp.secondaryColorList[index]) == cs.secondary
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
    );
  }
}

class PhaseSwitchSettings extends StatefulWidget {
  const PhaseSwitchSettings({Key? key}) : super(key: key);

  @override
  State<PhaseSwitchSettings> createState() => _PhaseSwitchSettingsState();
}

class _PhaseSwitchSettingsState extends State<PhaseSwitchSettings> {
  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    var tt = Theme.of(context).textTheme;
    return ListTile(
        title: const Text("Auto. Phasenwechsel"),
        subtitle: Text(
            "Schaltet am Ende jeder Phase automatisch auf Pause/Arbeit.",
            style: tt.bodySmall),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Provider.of<CountdownProvider>(context).auto
              ? Icon(Icons.sync_disabled_sharp, color: cs.onPrimary)
              : Icon(Icons.sync_sharp, color: cs.onPrimary),
        ),
        onTap: () => Provider.of<DatabaseProvider>(context, listen: false)
            .setAuto(
                !Provider.of<CountdownProvider>(context, listen: false).auto));
  }
}

class TimeSettings extends StatelessWidget {
  const TimeSettings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var tt = Theme.of(context).textTheme;
    return ListTile(
      title: const Text("Zeit-Einstellungen"),
      subtitle: Text("Timer-Länge für Arbeit/Pause.", style: tt.bodySmall),
      onTap: () =>
          Provider.of<CountdownProvider>(context, listen: false).status !=
                  "stop"
              ? showDialog(
                  context: context, builder: (context) => const TimeError())
              : showDialog(
                  context: context,
                  builder: (context) => const TimeSettingsAlert()),
    );
  }
}

class TimeSettingsAlert extends StatefulWidget {
  const TimeSettingsAlert({Key? key}) : super(key: key);

  @override
  State<TimeSettingsAlert> createState() => _TimeSettingsAlertState();
}

class _TimeSettingsAlertState extends State<TimeSettingsAlert> {
  int pValue = defaultPomodoro;
  int lbValue = defaultLBreak;
  int sbValue = defaultSBreak;
  int iValue = defaultInterval;

  void updateValues() {
    Provider.of<DatabaseProvider>(context, listen: false).setSettings(
        pValue,
        lbValue,
        sbValue,
        iValue,
        Provider.of<CountdownProvider>(context, listen: false).auto);
  }

  @override
  void initState() {
    super.initState();
    pValue = Provider.of<CountdownProvider>(context, listen: false).pTime;
    lbValue = Provider.of<CountdownProvider>(context, listen: false).lbTime;
    sbValue = Provider.of<CountdownProvider>(context, listen: false).sbTime;
    iValue = Provider.of<CountdownProvider>(context, listen: false).interval;
  }

  @override
  void dispose() {
    super.dispose();
    printHint("Disponsed (TimeSettings)");
  }

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    var tt = Theme.of(context).textTheme;
    return AlertDialog(
      //contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Arbeiten: ${pValue ~/ 60}"),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Slider.adaptive(
              value: (pValue ~/ 60).toDouble(),
              onChanged: (value) => setState(() => pValue = value.toInt() * 60),
              min: 1,
              max: 60,
              activeColor: cs.secondary,
              inactiveColor: cs.onPrimary,
            ),
          ),
          Text("Lange Pause: ${lbValue ~/ 60}"),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Slider.adaptive(
              value: (lbValue ~/ 60).toDouble(),
              onChanged: (value) =>
                  setState(() => lbValue = value.toInt() * 60),
              min: 1,
              max: 60,
              activeColor: cs.secondary,
              inactiveColor: cs.onPrimary,
            ),
          ),
          Text("Kurze Pause: ${sbValue ~/ 60}"),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Slider.adaptive(
              value: (sbValue ~/ 60).toDouble(),
              onChanged: (value) =>
                  setState(() => sbValue = value.toInt() * 60),
              min: 1,
              max: 60,
              activeColor: cs.secondary,
              inactiveColor: cs.onPrimary,
            ),
          ),
          Text("Phasen bis lange Pause: $iValue"),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Slider.adaptive(
              value: (iValue).toDouble(),
              onChanged: (value) => setState(() => iValue = value.toInt()),
              min: 1,
              max: 9,
              activeColor: cs.secondary,
              inactiveColor: cs.onPrimary,
            ),
          ),
          ElevatedButton(
            child: Text("Speichern",
                style: tt.labelMedium!.copyWith(color: cs.onSecondary)),
            onPressed: () {
              updateValues();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(primary: cs.secondary),
          )
        ],
      ),
    );
  }
}

class TimeError extends StatelessWidget {
  const TimeError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    var tt = Theme.of(context).textTheme;
    return AlertDialog(
      content: const Text("Stoppe zunächst deinen Timer, bevor du fortfährst."),
      actions: [
        TextButton(
          child: Text(
            "Abbrechen",
            style: tt.labelMedium,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: Text("Stoppen",
              style: tt.labelMedium!.copyWith(color: cs.onSecondary)),
          style: ElevatedButton.styleFrom(primary: cs.secondary),
          onPressed: () {
            Provider.of<CountdownProvider>(context, listen: false)
                .stop(context);
            Navigator.pop(context);
            showDialog(context: context, builder: (context) => TimeSettings());
          },
        )
      ],
    );
  }
}
