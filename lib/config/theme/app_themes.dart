import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    iconTheme: base.iconTheme.copyWith(
      color: Colors.black,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
  );
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      scaffoldBackgroundColor: Colors.white,
      iconTheme: base.iconTheme.copyWith(),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      textTheme: base.textTheme.copyWith(
        titleLarge:
            const TextStyle(color: Colors.black), // Change the body text color
        titleMedium: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15), // Change the body text color
        // Add more text styles if needed
      ),
      cardTheme: const CardTheme(
          color: Colors.white, shadowColor: Colors.black, elevation: 10));
}
