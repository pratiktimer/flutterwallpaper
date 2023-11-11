import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
      iconTheme: base.iconTheme.copyWith(
        color: Colors.white,
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      textTheme: base.textTheme.copyWith(
        bodyMedium: const TextStyle(color: Colors.white),
        headlineSmall: const TextStyle(
            color: Colors.white), // // Change the body text color
        titleMedium: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 15), // Change the body text color
        // Add more text styles if needed
      ),
      cardTheme: const CardTheme(
          //surfaceTintColor: Colors.white,
          //shadowColor: Colors.black,
          elevation: 4));
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
      scaffoldBackgroundColor: Colors.black,
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
        bodyMedium: const TextStyle(color: Colors.white),
        headlineSmall: const TextStyle(
            color: Colors.white), // // Change the body text color
        titleLarge:
            const TextStyle(color: Colors.white), // Change the body text color
        titleMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15), // Change the body text color
        // Add more text styles if needed
      ),
      cardTheme: const CardTheme(
          shape: BeveledRectangleBorder(),
          color: Colors.black,
          //shadowColor: Colors.white,
          elevation: 4));
}
