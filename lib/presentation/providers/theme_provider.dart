import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Finally, we are using ChangeNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
  return ThemeProvider();
});

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.system;

  setSelectedThemeMode() async {
    selectedThemeMode =
        selectedThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    var prefs = await SharedPreferences.getInstance();
    // Save an integer value to 'counter' key.
    await prefs.setBool('isDarkTheme', selectedThemeMode == ThemeMode.dark);

    getSelectedThemeMode();

    notifyListeners();
  }

  Future<void> getSelectedThemeMode() async {
    var prefs = await SharedPreferences.getInstance();
    // Save an integer value to 'counter' key.
    bool? isDarkTheme = await prefs.getBool('isDarkTheme');
    selectedThemeMode =
        isDarkTheme != null && isDarkTheme ? ThemeMode.dark : ThemeMode.light;

    if (selectedThemeMode == ThemeMode.light) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark));
    }
  }
}
