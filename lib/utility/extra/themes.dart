// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

// This is our  main focus
// Let's apply light and dark theme on our app
// Now let's add dark theme on our app

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: gLPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: gSecondaryColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: gLPrimaryColor),
    colorScheme: ColorScheme.light(
      primary: gLPrimaryColor,
      secondary: gSecondaryColor,
      error: kErrorColor,
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: Colors.white,
    //   selectedItemColor: kContentColorLightTheme.withOpacity(0.7),
    //   unselectedItemColor: kContentColorLightTheme.withOpacity(0.32),
    //   selectedIconTheme: IconThemeData(color: kPrimaryColor),
    //   showUnselectedLabels: true,
    // ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  // Bydefault flutter provie us light and dark theme
  // we just modify it as our need
  return ThemeData.dark().copyWith(
    primaryColor: gDPrimaryColor,
    scaffoldBackgroundColor: gSecondaryColor,
    iconTheme: IconThemeData(color: kContentColorDarkTheme),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: kContentColorDarkTheme),
    colorScheme: ColorScheme.dark().copyWith(
      primary: gDPrimaryColor,
      secondary: gSecondaryColor,
      error: kErrorColor,
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: kContentColorLightTheme,
    //   selectedItemColor: Colors.white70,
    //   unselectedItemColor: kContentColorDarkTheme.withOpacity(0.32),
    //   selectedIconTheme: IconThemeData(color: kPrimaryColor),
    //   showUnselectedLabels: true,
    // ),
  );
}

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
