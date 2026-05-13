import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: GoogleFonts.poppins().fontFamily,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryRed,
      secondary: AppColors.glowRed,
      surface: AppColors.surface,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primaryRed,
      unselectedItemColor: AppColors.lightText,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    cardColor: AppColors.surface,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: AppColors.lightText,
      ),
    ),
  );
}