import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncodoro/utils/providers/google_provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          icon: FaIcon(FontAwesomeIcons.google,
              color: Theme.of(context).colorScheme.secondary),
          label: const Text("Mit Google anmelden"),
          onPressed: () =>
              Provider.of<GoogleProvider>(context, listen: false).googleLogin(),
        ),
      ),
    );
  }
}
