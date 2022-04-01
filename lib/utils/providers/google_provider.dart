import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:syncodoro/utils/console.dart';

class GoogleProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _googleUser;
  GoogleSignInAccount get user => _googleUser!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _googleUser = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      printError("Google-Login failed (firebase) | \"$e\"");
    }

    notifyListeners();
  }

  Future googleLogout(context) async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }
}
