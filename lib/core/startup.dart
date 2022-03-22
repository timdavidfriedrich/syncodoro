import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:syncodoro/main.dart';
import 'package:syncodoro/screens/login.dart';

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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return const Main();
          } else if (snapshot.hasError) {
            return const Scaffold(
                body: Center(child: Text("Critical error!!")));
          } else {
            return const Login();
          }
        });
  }
}
