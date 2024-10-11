import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme() {
  return ThemeData(
      scaffoldBackgroundColor: Color(0xfff8f8f8),
      textTheme: GoogleFonts.quicksandTextTheme(),
      appBarTheme: appBarTheme(),
      useMaterial3: true
  );
}

AppBarTheme appBarTheme() {
  return  AppBarTheme(
    color: AppColors.themeColor,
    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: GoogleFonts.quicksand(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
    actionsIconTheme: const IconThemeData(color: Colors.white),

  );
}

class AppColors {
  static const Color themeColor = Color(0xff0c1739);
  static const Color navButtonsColor = Color(0xff0c1739);
}