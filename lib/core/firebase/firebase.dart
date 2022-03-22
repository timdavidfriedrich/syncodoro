import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:syncodoro/utils/console.dart';

//! Bei Veröffentlichung müssen Keys in Firebase Console
//! mit denen aus der Play Console ausgetauscht werden.

class DatabaseProvider extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser!;

  final CollectionReference userData =
      FirebaseFirestore.instance.collection("userData");

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream = FirebaseFirestore
      .instance
      .collection("userData")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  Future<DocumentSnapshot<Map<String, dynamic>>> userFuture = FirebaseFirestore
      .instance
      .collection("userData")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  Future checkIfUserExists() async {
    return (await userData.doc(user.uid).get()).exists ? true : false;
  }

  Future setStatus(String status, int timeStarted) async {
    return await userData.doc(user.uid).set({
      "status": status,
      "timeStarted": timeStarted,
    }, SetOptions(merge: true));
  }

  Future setSettings(int pTime, int bTime) async {
    return await userData.doc(user.uid).set({
      "pTime": pTime,
      "bTime": bTime,
    }, SetOptions(merge: true));
  }

  Stream getData() {
    return userData.doc(user.uid).snapshots();
  }
}

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
      printError(e.toString());
    }

    notifyListeners();
  }

  Future googleLogout(context) async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }
}
