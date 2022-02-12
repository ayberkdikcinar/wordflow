import 'package:flutter/material.dart';

class AppThemeLight {
  static AppThemeLight? _instance;
  static AppThemeLight? get instance {
    if (_instance == null) return _instance = AppThemeLight._init();
    return _instance;
  }

  AppThemeLight._init();

  ThemeData get theme => myTheme;

  ThemeData get myTheme => ThemeData(
        fontFamily: 'Ubuntu',
        iconTheme:
            const IconThemeData(color: Color(0xffe53935)), //Default Icon Color
        primaryColor: const Color(0xffca3e47),
        primaryColorDark: const Color(0xFF302828),
        scaffoldBackgroundColor: const Color(0xFFE4E4E4),
        toggleableActiveColor: const Color(0xfff44336),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
          primary: const Color(0xffca3e47),
          secondary: const Color(0xfff44336), // Your accent color
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
              color: Colors.black87, fontFamily: 'Ubuntu', fontSize: 16),
        ),

        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black87.withOpacity(0.6),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xffca3e47)),
      );
}
