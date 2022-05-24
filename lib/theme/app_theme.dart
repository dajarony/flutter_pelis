import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color primary = Colors.indigo;
  static ThemeData tema = ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
    color: Colors.indigo,
    elevation: 0.5,
    titleTextStyle: GoogleFonts.pacifico(
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  ));
}
