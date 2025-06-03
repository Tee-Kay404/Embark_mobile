import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      inversePrimary: Colors.grey.shade100,
      primary: Colors.blue.shade800,
      secondary: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      bodySmall: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );

  // DarkMode
  ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
      surface: const Color(0xFF121212),
      inversePrimary: Colors.grey.shade900,
      primary: Colors.blue.shade300,
      secondary: Colors.white70,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white70),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade300,
        foregroundColor: Colors.black,
      ),
    ),
  );
}
