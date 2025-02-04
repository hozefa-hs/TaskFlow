import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    var box = await Hive.openBox('settings');
    state = box.get('isDarkMode', defaultValue: false);
  }

  Future<void> toggleTheme() async {
    var box = await Hive.openBox('settings');
    state = !state;
    box.put('isDarkMode', state);
  }
}
