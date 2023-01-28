import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:syncodoro/screens/home_desktop.dart';

import 'package:syncodoro/utils/providers/color_provider.dart';
import 'package:syncodoro/config/themes/theme_config.dart';
import 'package:syncodoro/constants/app_constants.dart';
import 'package:syncodoro/core/scaffold/app_bar.dart';
import 'package:syncodoro/core/startup.dart';
import 'package:syncodoro/screens/home_landscape.dart';
import 'package:syncodoro/screens/home_portrait.dart';
import 'package:syncodoro/utils/console.dart';
import 'package:syncodoro/utils/providers/database_provider.dart';
import 'package:syncodoro/utils/providers/google_provider.dart';
import 'package:syncodoro/utils/responsive.dart';
import 'package:syncodoro/utils/providers/countdown_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Root-Widget
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => CountdownProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => GoogleProvider()),
      ],
      child: const ThemeHandler(home: StartUp()), // links to Main()
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Timer? timer;

  update(snap) async {
    try {
      var value = await snap.data!.data();
      Provider.of<CountdownProvider>(context, listen: false).updateData(
        value["type"] ?? defaultType,
        value["status"] ?? defaultStatus,
        value["started"] ?? defaultStarted,
        value["remain"] ?? defaultRemain,
        value["pTime"] ?? defaultPomodoro,
        value["lbTime"] ?? defaultLBreak,
        value["sbTime"] ?? defaultSBreak,
        value["count"] ?? defaultCount,
        value["interval"] ?? defaultInterval,
        value["auto"] ?? defaultAuto,
      );
    } catch (e) {
      printError("Data not found (main) | \"$e\"");
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ColorProvider>(context, listen: false).initColors();
    Provider.of<CountdownProvider>(context, listen: false).runTimer(context);
    Provider.of<DatabaseProvider>(context, listen: false).updateUser();

    printHint("InitState (main)");
  }

  @override
  void dispose() {
    //Provider.of<CountdownProvider>(context, listen: false).stopTimer();
    printHint("Disposed (main)");
    super.dispose();
  }

  // Home-Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScaffoldAppBar(),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: Provider.of<DatabaseProvider>(context).userStream,
        builder: (context, snap) {
          if (snap.hasError) {
            printError("StreamBuilder (main) | \"${snap.error}\"");
            return const Center(child: Text("Error: StreamBuilder"));
          } else if (snap.hasData) {
            update(snap);
            return const Responsive(
              portrait: HomePortrait(),
              landscape: HomeLandscape(),
              desktop: HomeDesktop(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary),
            );
          }
        },
      ),
    );
  }
}
