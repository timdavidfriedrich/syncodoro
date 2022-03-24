import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/config/themes/color_provider.dart';
import 'package:syncodoro/config/themes/theme_config.dart';
import 'package:syncodoro/core/firebase/firebase.dart';
import 'package:syncodoro/core/scaffold/app_bar.dart';
import 'package:syncodoro/core/startup.dart';
import 'package:syncodoro/screens/home_landscape.dart';
import 'package:syncodoro/screens/home_portrait.dart';
import 'package:syncodoro/utils/console.dart';
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
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => GoogleProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => CountdownProvider()),
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
  update(snap) async {
    var value = await snap.data!.data();
    Provider.of<CountdownProvider>(context, listen: false).updateData(
      value["type"],
      value["status"],
      value["time"],
      value["pTime"],
      value["bTime"],
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ColorProvider>(context, listen: false).initColors();
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
            printError("StreamBuilder (main)");
            return const Center(child: Text("Error: StreamBuilder"));
          } else if (snap.hasData) {
            update(snap);
            return const Responsive(
              portraitLayout: HomePortrait(),
              landscapeLayout: HomeLandscape(),
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
