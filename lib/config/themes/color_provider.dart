import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ColorProvider extends ChangeNotifier {
  Color secondaryColor = const Color(0xff4CAF50);
  int secondaryColorCode = 0xff4CAF50;
  late SharedPreferences prefs;

  List secondaryColorList = [
    0xFFeb3b5a,
    0xFFfa8231,
    0xFFf7b731,
    0xFF4caf50,
    0xFF2d98da,
    0xFF8854d0,
  ];

  Future<void> initColors() async {
    prefs = await SharedPreferences.getInstance();
    secondaryColorCode = prefs.getInt("secondaryColor") ?? secondaryColorCode;
    secondaryColor = Color(secondaryColorCode);
    notifyListeners();
  }

  Future<void> setSecondaryColor(int colorCode) async {
    prefs = await SharedPreferences.getInstance();
    secondaryColorCode = colorCode;
    secondaryColor = Color(secondaryColorCode);
    await prefs.setInt("secondaryColor", colorCode);
    notifyListeners();
  }
}
