import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_view/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1));

  static final darkThemeMode = ThemeData.dark().copyWith(

      appBarTheme: const AppBarTheme(backgroundColor: Pallete.backgroundColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Pallete.whiteColor,
          foregroundColor: Pallete.backgroundColor),
      scaffoldBackgroundColor: Pallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.poppins(),
          contentPadding: const EdgeInsets.all(27),
          focusedBorder: _border(Pallete.whiteColor),
          enabledBorder: _border(Pallete.borderColor)));
}
