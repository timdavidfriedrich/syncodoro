import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:syncodoro/main.dart';
import 'package:syncodoro/screens/login.dart';
import 'package:syncodoro/utils/console.dart';

class StartUp extends StatefulWidget {
  const StartUp({Key? key}) : super(key: key);

  @override
  State<StartUp> createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          } else if (snap.hasData) {
            return const Main();
          } else if (snap.hasError) {
            printError("Login (startup) | \"${snap.error}\"");
            return const Scaffold(body: Center(child: Text("Error: Startup")));
          } else {
            return const Login();
          }
        });
  }
}
