import 'package:audioplayers/audioplayers.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wordflow/core/base/model/base_gameviewmodel.dart';
import 'package:wordflow/core/init/network/network_manager.dart';
import 'package:wordflow/view/game/board/board.dart';
import 'package:wordflow/view/player/player.dart';
import 'package:wordflow/view/settings/settings_viewmodel.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:wordflow/view/wordsRelation/model/words_relation_model.dart';

import '../multi/game_multi_viewmodel.dart';
part 'game_single_viewmodel.g.dart';

enum ClickResponse { wordIsTrue, wordIsFalse, notYourTurn }

class GameSingleViewModel = _GameSingleViewModelBase with _$GameSingleViewModel;

abstract class _GameSingleViewModelBase extends BaseGameViewModel with Store {
  late BuildContext context;

  @observable
  late IO.Socket socket;
  @observable
  int round = 0;
  @observable
  bool isGameFinished = false;
  NetworkManager networkManager = NetworkManager.instance;
  @observable
  int clickCount = 0;

  @observable
  GameStatus gameStatus = GameStatus.initializing;

  Board board = Board();
  Player player = Player("You");

  @action
  Future<bool> getDataFromAPI() async {
    String path = "http://20.117.168.133:5000/";
    if (currentGameLanguage() == Language.turkish) {
      path = "http://20.117.168.133:5000/tr";
    }
    var testDataEN = await networkManager.dioGet(path: path, model: WordsRelation());

    if (testDataEN != null) {
      List<WordsRelation> list = testDataEN.cast<WordsRelation>();
      getModelAndFillData(list);
      return true;
    } else {
      return false;
    }
  }

  @action
  void getModelAndFillData(List<WordsRelation> list) {
    board.clearData();

    board.fillTable(list);

    board.setCurrentHint(round, currentGameLanguage());
    board.applyRandomness();
  } //yes

  @override
  @action
  ClickResponse cardClicked(String cardText) {
    ///hinti burda değiştiriyorum, oyunu burada bitiriyorum, textin doğruluğunu burada yapıyorum
    clickCount++;

    ClickResponse response = checkTheCorrectnessOfWord(cardText);

    if (clickCount == board.allWords.length) {
      gameStatus = GameStatus.finished;
      clickCount = 0;
      round = 0;
    } else {
      bool isRoundChange = false;
      while (int.parse(board.wordsRelationList[round].totalCount!) == 0) {
        round++;
        isRoundChange = true;
      }
      if (isRoundChange) {
        if (context.read<SettingsViewModel>().sfxState) {
          AudioCache soundPlayer = AudioCache();
          soundPlayer.play("sounds/word_changed.wav", mode: PlayerMode.LOW_LATENCY, stayAwake: false);
        }
        board.setCurrentHint(round, currentGameLanguage());
      }
    }

    /* if (clickCount == int.parse(board.wordsRelationList[round].totalCount!)) {
      debugPrint(board.wordsRelationList.length.toString());
      if (round < board.wordsRelationList.length - 1) {
        round++;
        clickCount = 0;
        board.setCurrentHint(round, currentGameLanguage());
      } else {
        gameStatus = GameStatus.finished;
      }
    }*/
    return response;
  }

  @override
  @action
  ClickResponse checkTheCorrectnessOfWord(String clickedWord) {
    try {
      if (board.wordsRelationList[round].relatedWords!.contains(clickedWord)) {
        player.setScore(player.getScore + 10);
        int totalCount = int.parse(board.wordsRelationList[round].totalCount!);
        board.wordsRelationList[round].totalCount = (totalCount - 1).toString();
        return ClickResponse.wordIsTrue;
      }
      player.setScore(player.getScore - 2);
      for (var item in board.wordsRelationList) {
        if (item.relatedWords!.contains(clickedWord)) {
          item.totalCount = (int.parse(item.totalCount!) - 1).toString();
        }
      }
      return ClickResponse.wordIsFalse;
    } catch (e) {
      return ClickResponse.wordIsFalse;
    }
  }

  @override
  Language currentGameLanguage() {
    return context.read<SettingsViewModel>().gameLanguage;
  }
}
