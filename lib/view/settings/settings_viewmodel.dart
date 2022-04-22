import 'package:flutter/material.dart';

enum Language { english, turkish }
enum Timer { short, normal, high }

class SettingsViewModel extends ChangeNotifier {
  //bool musicState = true;
  bool _sfxState = true;
  Language _language = Language.english;
  Timer timer = Timer.normal;

  void changeGameLanguage(Language language) {
    _language = language;
    notifyListeners();
  }

  void changeSFXState(bool sfx) {
    _sfxState = sfx;
    notifyListeners();
  }

  bool get sfxState {
    return _sfxState;
  }

  Language get gameLanguage {
    return _language;
  }
}
