import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:syncodoro/main.dart';
import 'package:syncodoro/config/themes/light_theme.dart';
import 'package:syncodoro/config/themes/dark_theme.dart';
import 'package:syncodoro/config/themes/color_provider.dart';

class ThemeHandler extends StatelessWidget {
  final Widget home;
  const ThemeHandler({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(
        context,
        lightPrimary,
        lightOnPrimary,
        Provider.of<ColorProvider>(context).secondaryColor, //lightSecondary,
        lightOnSecondary,
        lightBackground,
        lightSurface,
        lightHint,
        lightBorder,
        lightError,
      ),
      darkTheme: theme(
        context,
        darkPrimary,
        darkOnPrimary,
        Provider.of<ColorProvider>(context).secondaryColor, //darkSecondary,
        darkOnSecondary,
        darkBackground,
        darkSurface,
        darkHint,
        darkBorder,
        darkError,
      ),
      home: home,
    );
  }

  theme(context, primary, onPrimary, secondary, onSecondary, background,
      surface, hint, border, error) {
    //
    return ThemeData(
      primaryColor: primary,
      //primarySwatch: customSwatch(primaryColor.value),
      //accentColor: secondaryColor,
      focusColor: secondary,
      cardColor: surface,
      canvasColor: surface,
      disabledColor: secondary.withOpacity(0.2),
      backgroundColor: background,
      scaffoldBackgroundColor: background,
      errorColor: error,
      hintColor: hint,
      dividerColor: hint,
      //buttonColor: secondaryColor,
      hoverColor: primary,
      indicatorColor: secondary,
      bottomAppBarColor: primary,
      dialogBackgroundColor: surface,
      colorScheme: ColorScheme(
        primary: primary,
        //primaryVariant: borderColor,
        onPrimary: onPrimary,
        secondary: secondary,
        //secondaryVariant: secondaryColor,
        onSecondary: onSecondary,
        surface: surface,
        onSurface: onPrimary,
        background: background,
        onBackground: onPrimary,
        error: error,
        onError: onPrimary,
        brightness: Brightness.light,
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,

      ///* AppBar
      appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),

      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? secondary.withOpacity(0.5)
                : border),
        thumbColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected) ? secondary : onPrimary),
      ),

      iconTheme: IconThemeData(color: onPrimary),

      ///* TextButton
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(onPrimary),
        ),
      ),

      ///* Text-Themes
      textTheme: TextTheme(
        titleSmall: GoogleFonts.azeretMono(color: Colors.blue[300]),
        titleMedium: GoogleFonts.azeretMono(color: onPrimary),
        titleLarge: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.azeretMono(color: Colors.pink[300]),
        headlineMedium: GoogleFonts.azeretMono(color: Colors.pink[600]),
        headlineLarge: GoogleFonts.azeretMono(color: Colors.pink[900]),
        displaySmall: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        displayMedium: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        displayLarge: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 72,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.azeretMono(color: Colors.amber[300]),
        bodyMedium: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.azeretMono(color: Colors.amber[900]),
        labelSmall: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 10,
        ),
        labelMedium: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 12,
        ),
        labelLarge: GoogleFonts.azeretMono(
          color: onPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),

      ///* TextField-Themes etc.
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: secondary,
        selectionColor: hint,
        selectionHandleColor: secondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: hint),
        labelStyle: TextStyle(color: border),
        alignLabelWithHint: true,
        fillColor: surface,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: border),
            borderRadius: BorderRadius.circular(16)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: border),
            borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondary),
            borderRadius: BorderRadius.circular(16)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: error),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  customSwatch(color) {
    return MaterialColor(
      color,
      <int, Color>{
        50: Color(color),
        100: Color(color),
        200: Color(color),
        300: Color(color),
        400: Color(color),
        500: Color(color),
        600: Color(color),
        700: Color(color),
        800: Color(color),
        900: Color(color),
      },
    );
  }
}
