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
import 'package:syncodoro/utils/responsive.dart';
import 'package:syncodoro/widgets/countdown.dart';

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
  StreamSubscription? stream;

  @override
  void initState() {
    super.initState();
    Provider.of<ColorProvider>(context, listen: false).initColors();
    stream = FirebaseFirestore.instance
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((data) {
      var value = data.data()!;
      Provider.of<CountdownProvider>(context, listen: false).updateData(
        value["status"],
        value["timeStarted"],
        value["pTime"],
        value["bTime"],
      );
    });
  }

  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }

  // Home-Widget
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ScaffoldAppBar(),
      body: Responsive(
        portraitLayout: HomePortrait(),
        landscapeLayout: HomeLandscape(),
      ),
    );
  }
}
