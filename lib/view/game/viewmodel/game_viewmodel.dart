import 'package:mobx/mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/view/game/board/board.dart';
import 'package:wordflow/view/game/player/player.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';

part 'game_viewmodel.g.dart';

enum ClickResponse { wordIsTrue, wordIsFalse }

class GameViewModel = _GameViewModelBase with _$GameViewModel;

abstract class _GameViewModelBase with Store {
  late BuildContext context;
  @observable
  int round = 0;
  @observable
  bool isGameFinished = false;

  @observable
  int clickCount = 0;

  Board board = Board();
  Player player = Player("Ayberk");
 
  @action
  void getModelAndFillData() {
    if (currentGameLanguage() == Language.turkish) {
      var testDataTR = [
        {
          "hint": "ülke",
          "relatedWords": ["Mısır", "Fransa", "Turkiye"],
          "totalCount": "3"
        },
        {
          "hint": "yeşil",
          "relatedWords": ["Dolar", "Uzaylı"],
          "totalCount": "2"
        },
        {
          "hint": "tenis",
          "relatedWords": ["Raket", "Basketbol", "Masa"],
          "totalCount": "3"
        },
        {
          "hint": "formula",
          "relatedWords": ["Araba", "Yarış", "Mersedes"],
          "totalCount": "3"
        },
        {
          "hint": "godzilla",
          "relatedWords": ["Tokyo", "Dev", "Dinozor", "Film"],
          "totalCount": "4"
        },
      ];
      board.fillTable(testDataTR);
    } else {
      var testDataEN = [
        {
          "hint": "country",
          "relatedWords": ["Egypt", "France", "Turkey"],
          "totalCount": "3"
        },
        {
          "hint": "green",
          "relatedWords": ["Dollar", "Alien"],
          "totalCount": "2"
        },
        {
          "hint": "tennis",
          "relatedWords": ["Racket", "Basketball", "Table"],
          "totalCount": "3"
        },
        {
          "hint": "formula",
          "relatedWords": ["Car", "Race", "Mercedes"],
          "totalCount": "3"
        },
        {
          "hint": "godzilla",
          "relatedWords": ["Tokyo", "Giant", "Dinosaur", "Movie"],
          "totalCount": "4"
        },
      ];
      board.fillTable(testDataEN);
    }
    board.setCurrentHint(round, currentGameLanguage());
  } //yes

  @action
  ClickResponse cardClicked(String cardText) {
    ///hinti burda değiştiriyorum, oyunu burada bitiriyorum, textin doğruluğunu burada yapıyorum
    clickCount++;
    debugPrint(player.getScore.toString());
    ClickResponse response = isWordTrue(cardText);

    if (clickCount == int.parse(board.wordsRelationList[round].totalCount!)) {
      debugPrint(board.wordsRelationList.length.toString());
      if (round < board.wordsRelationList.length - 1) {
        round++;
        clickCount = 0;
        board.setCurrentHint(round, currentGameLanguage());
      } else {
        changeGameStatus();
      }
    }
    return response;
  }

  @action
  ClickResponse isWordTrue(String clickedWord) {
    if (board.wordsRelationList[round].relatedWords != null) {
      if (board.wordsRelationList[round].relatedWords!.contains(clickedWord)) {
        player.setScore(player.getScore + 1);
        return ClickResponse.wordIsTrue;
      }
      return ClickResponse.wordIsFalse;
    }
    return ClickResponse.wordIsFalse;
  }

  @action
  Future<void> changeGameStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    isGameFinished = !isGameFinished;
  }

  Language currentGameLanguage() {
    return context.read<SettingsViewModel>().gameLanguage;
  }
}
