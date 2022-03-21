import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/config/themes/color_provider.dart';
import 'package:syncodoro/config/themes/theme_config.dart';
import 'package:syncodoro/core/scaffold/app_bar.dart';
import 'package:syncodoro/screens/home_landscape.dart';
import 'package:syncodoro/screens/home_portrait.dart';
import 'package:syncodoro/utils/responsive.dart';
import 'package:syncodoro/widgets/countdown.dart';

void main() {
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
      ],
      child: const ThemeHandler(home: Main()),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    Provider.of<ColorProvider>(context, listen: false).initColors();
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
