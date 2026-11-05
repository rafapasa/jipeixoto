import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const offWhite = Color(0xFFFFF7F9);
  static const blush = Color(0xFFF8E4EA);
  static const rose = Color(0xFFE2187A);
  static const roseSoft = Color(0xFFFF4DA0);
  static const roseDeep = Color(0xFFB0105C);
  static const black = Color(0xFF111111);
  static const ink = Color(0xFF1C1917);
  static const muted = Color(0xFF6B6461);
  static const line = Color(0xFFE7D6DB);
}

class AppTheme {
  static ThemeData get light {
    final display = GoogleFonts.playfairDisplayTextTheme();
    final body = GoogleFonts.manropeTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.rose,
        onPrimary: AppColors.white,
        secondary: AppColors.black,
        surface: AppColors.white,
        onSurface: AppColors.ink,
      ),
      textTheme: body.copyWith(
        displayLarge: display.displayLarge?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w600,
          height: 1.05,
        ),
        displayMedium: display.displayMedium?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w600,
          height: 1.1,
        ),
        headlineMedium: display.headlineMedium?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: display.headlineSmall?.copyWith(
          color: AppColors.ink,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }
}
