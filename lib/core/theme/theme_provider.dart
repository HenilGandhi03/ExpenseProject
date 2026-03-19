import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = AsyncNotifierProvider<ThemeNotifier, bool>(
  ThemeNotifier.new,
);

class ThemeNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !(state.value ?? false);
    state = AsyncData(newValue);
    await prefs.setBool('isDarkMode', newValue);
  }

  Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    state = AsyncData(isDark);
    await prefs.setBool('isDarkMode', isDark);
  }
}
