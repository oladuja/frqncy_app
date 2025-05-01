import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData theme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1B062B),
  primaryColor: const Color(0xFF6D349E),
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF6D349E),
    secondary: Color(0xFF6D349E),
    surface: Color(0xFF1B062B),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF6D349E),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: GoogleFonts.montserratTextTheme().apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
);
