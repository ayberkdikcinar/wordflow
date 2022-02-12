import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wordflow/core/init/theme/app_theme_dark.dart';

import '../../constans/enums/preferances_keys.dart';
import '../cache/cache_manager.dart';
import 'app_theme_light.dart';

enum EnumAppThemes {
  light,
  dark,
}

class ThemeManager extends ChangeNotifier {
  ThemeData? _currentTheme;
  bool darkMode = false;
  ThemeData? currentTheme() {
    darkMode = CacheManager.instance.containsKey(PreferancesKeys.darkMode)
        ? CacheManager.instance.getBoolValue(PreferancesKeys.darkMode)
        : SchedulerBinding.instance!.window.platformBrightness ==
            Brightness.dark;
    if (darkMode) {
      _currentTheme = AppThemeDark.instance!.theme;
    } else {
      _currentTheme = AppThemeLight.instance!.theme;
    }
    return _currentTheme;
  }

  void changeTheme(EnumAppThemes theme) {
    if (theme == EnumAppThemes.light) {
      _currentTheme = AppThemeLight.instance!.theme;
    } else {
      _currentTheme = AppThemeDark.instance!.theme;
    }
    notifyListeners();
  }

  void saveDarkMode() {
    CacheManager.instance.setBoolValue(PreferancesKeys.darkMode, darkMode);
  }

  void changeDarkMode(bool value) {
    darkMode = value;
    notifyListeners();
    saveDarkMode();
  }
}
