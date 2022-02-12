import 'package:flutter/material.dart';

class AppThemeDark {
  static AppThemeDark? _instance;
  static AppThemeDark? get instance {
    if (_instance == null) return _instance = AppThemeDark._init();
    return _instance;
  }

  AppThemeDark._init();

  ThemeData get theme => myTheme;

  ThemeData get myTheme => ThemeData(
        fontFamily: 'Ubuntu',
        iconTheme:
            const IconThemeData(color: Color(0xffca3e47)), //Default Icon Color
        primaryColor: const Color(0xffca3e47),
        primaryColorDark: Colors.black,

        toggleableActiveColor: const Color(0xffca3e47),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
          primary: const Color(0xffca3e47),
          secondary: const Color(0xffca3e47), // Your accent color
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'Ubuntu', fontSize: 16),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF1B1B1B),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xffca3e47),
        ),
      );
}
