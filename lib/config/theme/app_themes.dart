import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  final ThemeData base =
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);
  return base.copyWith(
    cardTheme: const CardTheme(shape: BeveledRectangleBorder(), elevation: 4),
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
  final ThemeData base =
      ThemeData(useMaterial3: true, colorScheme: darkColorScheme);
  return base.copyWith(
    cardTheme: const CardTheme(
        shape: BeveledRectangleBorder(),

        //shadowColor: Colors.white,
        elevation: 4),
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
          const TextStyle(color: Colors.white), // Change the body text color
      titleMedium:
          const TextStyle(color: Colors.white), // Change the body text color
      // Add more text styles if needed
    ),
  );
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006874),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF97F0FF),
  onPrimaryContainer: Color(0xFF001F24),
  secondary: Color(0xFF4A6267),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCDE7EC),
  onSecondaryContainer: Color(0xFF051F23),
  tertiary: Color(0xFF525E7D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFDAE2FF),
  onTertiaryContainer: Color(0xFF0E1B37),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFDFD),
  onBackground: Color(0xFF191C1D),
  surface: Color(0xFFFAFDFD),
  onSurface: Color(0xFF191C1D),
  surfaceVariant: Color(0xFFDBE4E6),
  onSurfaceVariant: Color(0xFF3F484A),
  outline: Color(0xFF6F797A),
  onInverseSurface: Color(0xFFEFF1F1),
  inverseSurface: Color(0xFF2E3132),
  inversePrimary: Color(0xFF4FD8EB),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF006874),
  outlineVariant: Color(0xFFBFC8CA),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4FD8EB),
  onPrimary: Color(0xFF00363D),
  primaryContainer: Color(0xFF004F58),
  onPrimaryContainer: Color(0xFF97F0FF),
  secondary: Color(0xFFB1CBD0),
  onSecondary: Color(0xFF1C3438),
  secondaryContainer: Color(0xFF334B4F),
  onSecondaryContainer: Color(0xFFCDE7EC),
  tertiary: Color(0xFFBAC6EA),
  onTertiary: Color(0xFF24304D),
  tertiaryContainer: Color(0xFF3B4664),
  onTertiaryContainer: Color(0xFFDAE2FF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF191C1D),
  onBackground: Color(0xFFE1E3E3),
  surface: Color(0xFF191C1D),
  onSurface: Color(0xFFE1E3E3),
  surfaceVariant: Color(0xFF3F484A),
  onSurfaceVariant: Color(0xFFBFC8CA),
  outline: Color(0xFF899294),
  onInverseSurface: Color(0xFF191C1D),
  inverseSurface: Color(0xFFE1E3E3),
  inversePrimary: Color(0xFF006874),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF4FD8EB),
  outlineVariant: Color(0xFF3F484A),
  scrim: Color(0xFF000000),
);
