import 'package:wordflow/view/game/board/board.dart';
import 'package:wordflow/view/game/single/game_single_viewmodel.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';

abstract class BaseGameViewModel {
  void getModelAndFillData();
  ClickResponse checkTheCorrectnessOfWord(String clickedWord);
  Language currentGameLanguage();
  ClickResponse cardClicked(String cardText);
}
