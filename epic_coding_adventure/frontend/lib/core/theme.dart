import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E), // VS Code Dark
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4CAF50), // Python Green
      secondary: Color(0xFF2196F3), // Blue
      surface: Color(0xFF252526), // Surface
      error: Color(0xFFF44336),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFFCCCCCC),
    ),
    textTheme: GoogleFonts.sourceCodeProTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: const Color(0xFFCCCCCC),
      displayColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF252526),
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.sourceCodePro(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
