import 'package:flutter/material.dart';

enum Language { english, turkish }
enum Timer { short, normal, high }

class SettingsViewModel extends ChangeNotifier {
  bool musicState = true;
  bool sfxState = true;
  Language _language = Language.english;
  Timer timer = Timer.normal;

  void changeGameLanguage(Language language) {
    _language = language;
    notifyListeners();
  }

  Language get gameLanguage {
    return _language;
  }
}
